import 'dart:io';

import 'file:///C:/MobileApps/Apps/Clima-Flutter/lib/utilities/localInteraction.dart';
import 'package:clima/services/gplaces.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';

// Dialog box for use

class MyDialog extends StatefulWidget {
  final String newCity, dialogText, okButtonText, cancelButtonText;
  final Widget dialogWidget;
  final Function onDialogSubmit;

  MyDialog(
      {this.newCity,
      this.dialogWidget,
      @required this.dialogText,
      this.onDialogSubmit,
      @required this.okButtonText,
      @required this.cancelButtonText}
      );

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {

  List<String> _suggestions = [];
  GPlaces gplaces = GPlaces();
  String updateCity;
  bool _btnEnable;

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final searchController = TextEditingController();

  LocalStorage lStorage = LocalStorage();
  WeatherModel weatherCustom = WeatherModel();

  void initState() {
    super.initState();
    print('initState: init');
    _suggestions = [
      'Type the name of a city, wait for the suggestions and ',
      'select a location from suggestions.',
      'Click outside dialog to dismiss!'
    ];
    searchController.clearComposing();
    searchController.clear();
    _btnEnable=false;
  }

  //TODO: Make sure to implement dispose function such that TextEditingController is disposed and so is the the dialog
//  @override
//  void dispose() {
//    // Clean up the controller when the widget is removed from the
//    // widget tree.
//    searchController.dispose();
//    super.dispose();
//  }

  Future<void> resetSugggestions(text) async {
    List<String> _tempsuggestions=[];
    _suggestions.clear();
    if(searchController.text.isEmpty || (text == '')){
      searchController.clearComposing();
      _tempsuggestions = [
        'Type the name of a city,',
        'wait for the suggestions and ',
        'select a location from suggestions',
      ];
    }else{
      _tempsuggestions = await gplaces.getSuggestions(text);
      if (_tempsuggestions.length == 0) { _tempsuggestions = ['Um, that\'s not a place', 'wana redo?', 'maybe check the speeling...']; }
      if (_tempsuggestions.length > 3) { _tempsuggestions = _tempsuggestions.getRange(0, 3).toList(); }
    }
    setState(() {
      _suggestions = _tempsuggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.7),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      insetPadding: EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTextwithGesture(widget.dialogText, 20.0),
              SizedBox(
                height: 5,
              ),
              //search field for new city
              TextField(
                controller: searchController,
                autofocus: true,
                autocorrect: true,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                decoration: kTextFieldInputDecoration,
                onChanged: (text)  {
                  if (text == null) {
                      searchController.selection = TextSelection.collapsed(offset: 0);
                    }
                  setState(() {
                    if(_suggestions.contains(searchController.text)) {_btnEnable =true;}
                    else { _btnEnable=false; }
                  });
                  resetSugggestions(text);
                },
              ),
// TODO: Make sure the suggestion area is size flexible, without suggestion its height should be 0 and with suggestion it should be equal to the height of suggestions
              Container(
                height: 100,
                child: ListView(
                  children: _suggestionSpace(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.green.withOpacity(.8),
                    elevation: 20,
                    onPressed: _btnEnable ? () {_saveNewCity();} : null,
                    child: Text(
                      widget.okButtonText,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
//                  SizedBox(
//                    width: 20,
//                  ),
                  //TODO: Implement dismiss button to make sure user can cancel without clicking outside the dialog
//                  RaisedButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(20.0)),
//                    color: Colors.red.withOpacity(.8),
//                    elevation: 20,
//                    onPressed: () {
//                      Navigator.pop(context, true);
//                      dispose();
//                    },
//                    child: Text(
//                      widget.cancelButtonText,
//                      style: TextStyle(
//                        fontSize: 15,
//                      ),
//                    ),
//                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNewCity() async {
    {
     var temp = await lStorage.readFile();
     if (temp.contains(updateCity)){
       setState(() {
         _suggestions = ['This city already exists', 'in the weather list.', 'You could try a new city!'];
       });
     }else {
       print('_saveNewCity: Writing to Cities file');
       await lStorage.writeFile(inputText: updateCity);
       setState(() {
         _suggestions = ['City is now added', 'Go back from dialog to check it', 'or you could search a new city!'];
       });
     }
   }
  }

  List<Widget> _suggestionSpace() {
    List<Widget> suggestionSpace = [];
    for(var i=0; i< _suggestions.length && i<3; i++) {
      suggestionSpace.add(_buildTextwithGesture(_suggestions[i], 15.0));
    }
    _suggestions.clear();
    return suggestionSpace;
  }

  GestureDetector _buildTextwithGesture(String suggestiontext, double font) {
    return GestureDetector(
      onTap: () async {
        searchController.text = suggestiontext;
        updateCity= suggestiontext;
        setState(() {
          _btnEnable=true;
          _suggestions = ['Cool, you found it', 'Press \'Save\' to add it', 'to the list'];
        });
        },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          suggestiontext,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: font, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
