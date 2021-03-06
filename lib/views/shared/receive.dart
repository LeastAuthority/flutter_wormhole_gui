import 'dart:io';
import 'dart:math';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReceiveScreenStates {
  TransferRejected,
  TransferCancelled,
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

class ReceiveSharedState extends ChangeNotifier {
  String? _code;

  PendingDownload? pendingDownload;

  int? get fileSize => pendingDownload?.size;
  String? get fileName => pendingDownload?.fileName;

  late bool isRequestingConnection = false;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  final Config config;
  late final String? defaultPathForPlatform;
  String? error;
  String? errorMessage;
  String? errorTitle;

  late final TextEditingController controller = new TextEditingController();
  late final Client client = Client(config);

  void Function() failWith(String errorMessage) {
    return () {
      throw Exception(errorMessage);
    };
  }

  void setState(void Function() change) {
    change();
    notifyListeners();
  }

  late void Function() acceptDownload =
      failWith("No accept download function set");
  late void Function() rejectDownload =
      failWith("No reject download function set");

  late CancelFunc cancelFunc = failWith("No cancel transfer function set");

  String? get path {
    final path = prefs?.get(PATH);

    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  void reset() {
    setState(() {
      _code = null;
      pendingDownload = null;
      isRequestingConnection = false;
      currentState = ReceiveScreenStates.Initial;
      error = null;
      errorMessage = null;
      errorTitle = null;

      progress = ProgressSharedState(setState, () {
        currentState = ReceiveScreenStates.FileReceiving;
      });
      cancelFunc = failWith("No cancel transfer function set");
    });
  }

  ReceiveSharedState(this.config) {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });

    if (Platform.isAndroid) {
      defaultPathForPlatform = ANDROID_DOWNLOADS_FOLDER_PATH;
    } else {
      getDownloadsDirectory().then((downloadsDir) {
        setState(() {
          defaultPathForPlatform = downloadsDir?.path;
        });
      });
    }
  }

  late ProgressSharedState progress = ProgressSharedState(setState, () {
    currentState = ReceiveScreenStates.FileReceiving;
  });

  void codeChanged(String code) {
    setState(() {
      _code = code;
      isRequestingConnection = false;
    });
  }

  static String _tempPath(String prefix) {
    final r = Random();
    int suffix = r.nextInt(1 << 32);
    while (File("$prefix.$suffix").existsSync()) {
      suffix = r.nextInt(1 << 32);
    }

    return "$prefix.$suffix";
  }

  void defaultErrorHandler(Object error) {
    this.setState(() {
      this.currentState = ReceiveScreenStates.ReceiveError;
      this.error = error.toString();
      this.errorTitle = "Error receiving file";
      print("Error receiving file\n$error");

      if (error is ClientError) {
        switch (error.errorCode) {
          case ErrCodeTransferRejected:
            this.currentState = ReceiveScreenStates.TransferRejected;
            break;
          case ErrCodeTransferCancelled:
            this.currentState = ReceiveScreenStates.TransferCancelled;
            break;
          case ErrCodeWrongCode:
            this.errorMessage = ERR_WRONG_CODE_RECEIVER;
        }
      }
    });

    throw error;
  }

  Future<ReceiveFileResult> receive() async {
    return await canWriteToDirectory(path!).then((canWrite) async {
      if (canWrite) {
        late final File tempFile;
        this.setState(() {
          isRequestingConnection = true;
        });
        return client.recvFile(_code!, progress.progressHandler).then((result) {
          result.done.then((value) async {
            this.setState(() {
              currentState = ReceiveScreenStates.FileReceived;
            });
            await tempFile.rename(nonExistingPathFor("$path" +
                Platform.pathSeparator +
                "${result.pendingDownload.fileName}"));
          }, onError: defaultErrorHandler);

          this.setState(() {
            currentState = ReceiveScreenStates.ReceiveConfirmation;
            acceptDownload = () {
              controller.text = '';
              tempFile = File(_tempPath("$path" +
                  Platform.pathSeparator +
                  "${result.pendingDownload.fileName}"));
              var cancelFunc =
                  result.pendingDownload.accept(tempFile.writeOnlyFile());
              this.setState(() {
                currentState = ReceiveScreenStates.FileReceiving;
                this.cancelFunc = cancelFunc;
              });
            };
            rejectDownload = () {
              result.pendingDownload.reject();
              reset();
            };
            pendingDownload = result.pendingDownload;
          });

          return result;
        }, onError: defaultErrorHandler);
      } else {
        final error =
            Exception("Permission denied. Could not write to ${path!}");
        defaultErrorHandler(error);
        return Future.error(error);
      }
    });
  }

  Widget widgetByState(
      Widget Function() receivingDone,
      Widget Function() receiveError,
      Widget Function() receiveProgress,
      Widget Function() enterCodeUI,
      Widget Function() receiveConfirmation,
      Widget Function() transferCancelled,
      Widget Function() transferRejected) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
        return receiveError();
      case ReceiveScreenStates.ReceiveConfirmation:
        return receiveConfirmation();
      case ReceiveScreenStates.FileReceived:
        return receivingDone();
      case ReceiveScreenStates.FileReceiving:
        return receiveProgress();
      case ReceiveScreenStates.TransferRejected:
        return transferRejected();
      case ReceiveScreenStates.TransferCancelled:
        return transferCancelled();
    }
  }
}
