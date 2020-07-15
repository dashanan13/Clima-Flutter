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

  Future<bool> IsNewLaunch()  async {
//    print('IsNewLaunch called');
    await localPath;
    if ((await File('$localdirectory/settings.txt').exists()) && (await File('$localdirectory/citynames.txt').exists())) {
      settingfilepath = await File('$localdirectory/settings.txt');
      citylistfilepath = await File('$localdirectory/citynames.txt');
//      print('IsNewLaunch: sending out false');
      return false;
    } else {
//      print('IsNewLaunch: sending out true and calling newlocalFile');
      await newlocalFile;
      return true;
    }
//    return newfileDecision;
  }

  Future<void> get newlocalFile async {
    try {
      final path = await localPath;
      settingfilepath = await File('$path/settings.txt').create();
      citylistfilepath = await File('$path/citynames.txt').create();
      citylistfilepath.writeAsStringSync('Local' + '|', mode: FileMode.write);
//      print('newlocalFile: Files initialized with local as element!');
    } catch (e) {
      // If encountering an error, return 0
      return e;
    }
  }

  Future<void> writeFile({@required String inputText}) async {
    if (await IsNewLaunch()) {
//      print('writeFile: New launch, calling newlocalFile');
      newlocalFile;
    }
    var temp = await readFile();
    if (!(temp.contains(inputText))){
//      print('writeFile: New text, proceeding to write');
      try { print('writeFile: Append mode: $inputText'); citylistfilepath.writeAsStringSync(inputText.trim() + '|', mode: FileMode.append); }
      catch (e) { return e; }
    }
  }

  Future<List<String>> readFile() async {
      if (await IsNewLaunch()) {
        print('writeFile: New launch, calling newlocalFile');
        newlocalFile;
      }else {
        print('readFile: Reading the file');
      }
      try {
        String tempText = await citylistfilepath.readAsString();
        print('readFile: ' + tempText.split('|').toString().trim());
        return tempText.split('|');
      } catch (e) {
        print(e);
        return e;
      }
    }

//TODO: Implement remove function
  Future<void> removeItem({@required List<String> inputText}) async {
    if (await IsNewLaunch()) {
//      print('writeFile: New launch, calling newlocalFile');
      newlocalFile;
    }
    readFile();
    print('removeItem: Text provided $inputText');
    try {
      for (var i=0; i< inputText.length; i++){
        if(inputText[i].toString().length > 0) {
          print('removeItem: Writing ${inputText[i]}');
          if(i==0) { citylistfilepath.writeAsStringSync(inputText[i].trim() +'|', mode: FileMode.write); }
          else { citylistfilepath.writeAsStringSync(inputText[i].trim() +'|', mode: FileMode.append); }
        }
      }
    }
    catch (e) { return e; }
  }

}


