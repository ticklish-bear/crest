import 'dart:js_interop';
import 'dart:convert';
import 'package:web/web.dart' as web;

/// Save CSV file on web by triggering a browser download
Future<String> saveCsvFile(String csvContent, String filename) async {
  final bytes = utf8.encode(csvContent);
  final jsArray = bytes.toJS;
  final blob = web.Blob([jsArray].toJS, web.BlobPropertyBag(type: 'text/csv'));
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename;
  anchor.click();
  web.URL.revokeObjectURL(url);
  return filename;
}
