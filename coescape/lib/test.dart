import 'dart:io';

void main() {
  print(File(Platform.script.toFilePath()).parent);
  File file = File(".env");
  String contents = file.readAsStringSync();
  print(contents);
}
