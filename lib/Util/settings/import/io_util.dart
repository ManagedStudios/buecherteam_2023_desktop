

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> getFilePickerResult () async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx']
  );
  return result;
}

String getFileNameOf (FilePickerResult res)  {
  PlatformFile file = res.files.first;
  return file.name;
}

Excel getExcelFileOf(FilePickerResult res) {
  File file = File(res.files.single.path!);
  var bytes = file.readAsBytesSync();
  Excel excel = Excel.decodeBytes(bytes);
  return excel;
}
