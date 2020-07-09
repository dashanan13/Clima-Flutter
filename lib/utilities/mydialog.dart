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
      @required this.cancelButtonText});

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {

  List<String> _suggestions = [];
  GPlaces gplaces = GPlaces();
  WeatherModel weatherCustom = WeatherModel();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final searchController = TextEditingController();

  void initState() {
    super.initState();
    print('init');
    _suggestions = [
      'New York US',
      'Delhi, India',
      'Oslo, Norway',
    ];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchController.dispose();
    super.dispose();
  }

  void resetSugggestions(List<String> _tempsuggestions){
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
                onChanged: (text) async {
                  List<String> _tempsuggestions = await gplaces.getSuggestions(text);
                  resetSugggestions(_tempsuggestions);
                },
                onSubmitted:(text) async {
                  List<String> _tempsuggestions = await gplaces.getSuggestions(text);
                  resetSugggestions(_tempsuggestions);
                },
              ),
              Container(
                height: 100,
                child: ListView(
                  children: <Widget>[
                    _buildTextwithGesture(_suggestions[0], 15.0),
                    _buildTextwithGesture(_suggestions[1], 15.0),
                    _buildTextwithGesture(_suggestions[2], 15.0),
                  ],
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
                    onPressed: () {},
                    child: Text(
                      widget.okButtonText,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.red.withOpacity(.8),
                    elevation: 20,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      widget.cancelButtonText,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildTextwithGesture(String suggestiontext, double font) {
    return GestureDetector(
      onTap: () async {
        print(suggestiontext);
          // TODO: access and replace text field string with suggestion
        searchController.text = suggestiontext;
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
