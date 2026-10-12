import 'dart:convert';
import 'dart:html' as html;

Future<void> downloadManagementFile({
  required String contents,
  required String fileName,
  required String mimeType,
}) async {
  final blob = html.Blob([utf8.encode(contents)], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);
  try {
    html.AnchorElement(href: url)
      ..download = fileName
      ..click();
  } finally {
    html.Url.revokeObjectUrl(url);
  }
}
