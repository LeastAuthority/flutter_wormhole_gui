import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

final wormholeWilliamPath = path.join('.', 'dart_wormhole_william', 'wormhole-william');
final testFileSrcDir = path.join('.', 'integration_test', 'client', 'test_files');
final testFileDestDir = path.join(testFileSrcDir, 'test_dest');
final goCliPath = path.join(testFileDestDir, 'ww_cli.exe');
final goCliFromTestFileDestPath = path.join('.', path.relative(goCliPath, from: testFileDestDir));

String sendTextGo(String text) {
  // TODO: read code from stdout (?)
  const code = "7-guitarist-revenge";
  final res = Process.run(goCliFromTestFileDestPath, [
    'send',
    '--code', code,
    '--text', text,
  ],
    workingDirectory: testFileDestDir,
  );
  res.then((_res) {
    print(_res.stdout);
  });
  return code;
}

String recvTextGo(String code) {
  final res = Process.runSync(goCliFromTestFileDestPath, [
    'receive',
    code,
  ],
    workingDirectory: testFileDestDir,
  );
  return res.stdout.toString().trimRight();
}

Future<File> recvFileGo(String code, String filename) async {
  final done = Completer<File>();
  final recvProcess = await Process.start(goCliFromTestFileDestPath, [
    'receive',
    code,
  ],
    workingDirectory: testFileDestDir,
  );

  recvProcess.stderr.listen((lineInts) {
    print(String.fromCharCodes(lineInts));
  });

  recvProcess.stdout.listen((lineInts) {
    final lineString = String.fromCharCodes(lineInts);
    if (lineString.contains('ok? (y/N):')) {
      recvProcess.stdin.write('y\n');
    }
  });

  await recvProcess.exitCode;
  return File(path.join(testFileDestDir, filename));
}

Future<ProcessResult> buildGoCli() {
  final buildOutPath = path.relative(goCliPath, from: wormholeWilliamPath);
  final resFuture = Process.run('go', [
    'build',
    '-o', buildOutPath,
    '.',
  ],
    workingDirectory: wormholeWilliamPath,
  );

  resFuture.then((res) {
    if (res.stderr != '') {
      print("ERROR running `go build -o $buildOutPath .`:");
      print(res.stderr);
    }
  });

  return resFuture;
}