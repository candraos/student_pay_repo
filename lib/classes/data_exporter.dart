import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_budget_planning/models/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class DataExporter {
  static Future<String> exportData() async {
    try {
      PermissionStatus status = await Permission.storage.request();
      if(status == PermissionStatus.granted){
        List<List<Map<String,dynamic>>> allData = await DatabaseHelper().getAllData();
        final String encodedData = jsonEncode(allData);
        final String downloadsPath = 'storage/emulated/0/Download';
          final File outputFile = File('/data/user/0/com.example.flutter_budget_planning/cache/file_picker/data.json');
          await outputFile.writeAsString(encodedData);
        return 'File saved at $downloadsPath/data.json';




      }
    return 'We need permission';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<dynamic>> importData() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print(result.files.single.path!);
      File file = File(result.files.single.path!);
      if (await file.exists()) {
        final String fileContents = await file.readAsString();
        print(fileContents);
        final  decodedData = jsonDecode(fileContents);
        print(decodedData);
        return decodedData;
      } else {
        throw FileSystemException('File not found');
      }
    } else {
      throw Exception("User Canceled Request");
    }



  }
}
