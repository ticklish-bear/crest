import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Save CSV file on mobile/desktop platforms using dart:io
Future<String> saveCsvFile(String csvContent, String filename) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$filename');
  await file.writeAsString(csvContent);
  return file.path;
}
