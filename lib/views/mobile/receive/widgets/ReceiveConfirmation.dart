import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveConfirmation extends StatelessWidget {
  final Function receive;
  ReceiveConfirmation(this.receive);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(
          title: FILE_READY_TO_DOWNLOAD,
          textAlign: TextAlign.left,
          marginTop: 0.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          // key: Key('Timing_Progress'),
        ),
        FileInfo(22, 'My file name'),
        Heading(
          title: PLEASE_KEEP_THE_APP_OPEN_UNTIL_FILE_IS_DOWNLOADED,
          textAlign: TextAlign.center,
          marginTop: 16.0.h,
          textStyle: Theme.of(context).textTheme.bodyText1,
          key: Key(APP_MUST_REMAIN_OPEN),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(title: DOWNLOAD, handleClicked: receive, disabled: false),
            Button(title: CANCEL, handleClicked: () {}, disabled: false),
          ],
        ),
        SizedBox(
          height: 8.0.h,
        )
      ],
    );
  }
}
