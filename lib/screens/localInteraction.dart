import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

// Class used to work with local files
class LocalStorage {
  String localdirectory;
  File settingfilepath, citylistfilepath;
  int newfileDecision;

  Future<String> get localPath async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      localdirectory = directory.path;
      return directory.path;
    } catch (e) {
      // If encountering an error, return 0
      return e;
    }
  }

  Future<void> get newlocalFile async {
    try {
      final path = await localPath;
      settingfilepath = await File('$path/settings.txt').create();
      citylistfilepath = await File('$path/citynames.txt').create();
      citylistfilepath.writeAsStringSync('Local' + '|', mode: FileMode.write);
      print('Files initialized!');
    } catch (e) {
      // If encountering an error, return 0
      return e;
    }
  }

  Future<void> writeFile({@required FileMode writeMode, @required String inputText, @required bool isCityNameFile}) async {
    if (await isnewlaunch()) {
      print('Writing to a new file');
    }else{
      print('Writing to an old file');
    }
    try {
      await citylistfilepath.writeAsStringSync(inputText + '|', mode: writeMode);
//      return await citylistfilepath.writeAsString(inputText, mode: FileMode.append);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<List<String>> readFile({@required bool isCityNameFile}) async {
    if (await isnewlaunch()) {
      return ['New file, no text to read'];
    }else{
      print('Reading the file');
      try {
//        citylistfilepath.readAsString().asStream().transform(LineSplitter()).listen((String line) { print(line);});
        String tempText = await citylistfilepath.readAsString();
        return tempText.split('|');;
      } catch (e) {
        print(e);
        return e;
      }
    }
  }

  Future<bool> isnewlaunch()  async {
//    Directory(await localPath).list(followLinks: false).listen((FileSystemEntity entity) {
//      if((entity.path.contains('settings.txt')) || (entity.path.contains('citynames.txt'))){
//        newfileDecision++;
//        print('${entity.path} : $newfileDecision');
//      }
//    });
    await localPath;
    if ((await File('$localdirectory/settings.txt').exists()) && (await File('$localdirectory/citynames.txt').exists())) {
      settingfilepath = await File('$localdirectory/settings.txt');
      citylistfilepath = await File('$localdirectory/citynames.txt');
      return false;
    } else {
      await newlocalFile;
      return true;
    }
//    return newfileDecision;
  }
}
