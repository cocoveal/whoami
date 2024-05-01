import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class SettingsParser {
  Map<String, dynamic> parsedJson = {};

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    if (directory != null) {
      return directory.path;
    } else {
      throw 'Could not get the path';
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/settings.json');
  }

  // Future<File> saveSettings(Map<String, dynamic> settings) async {
  //   final file = await _localFile;
  //   // Write the file
  //   final entry = jsonEncode(settings);
  // }

  Future<Map<String, dynamic>> loadSettings() async {
    String data = '';
    await rootBundle
        .loadString('lib/settings/settings.json')
        .then((value) => data += (value));
    parsedJson = jsonDecode(data);
    return parsedJson;
  }
}
