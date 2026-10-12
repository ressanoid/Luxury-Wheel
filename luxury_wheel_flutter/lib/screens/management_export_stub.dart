import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<void> downloadManagementFile({
  required String contents,
  required String fileName,
  required String mimeType,
}) async {
  final extension = fileName.split('.').last;
  await FilePicker.saveFile(
    dialogTitle: 'Save $fileName',
    fileName: fileName,
    type: FileType.custom,
    allowedExtensions: [extension],
    bytes: Uint8List.fromList(utf8.encode(contents)),
    mimeType: mimeType,
  );
}
