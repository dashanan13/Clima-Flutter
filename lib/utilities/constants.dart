import 'package:flutter/material.dart';

// Constants

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontSize: 15.0,
);

const kBoldTextStyle = TextStyle(
  fontSize: 25.0,
);

const kNormalTextStyle = TextStyle(
  fontSize: 20.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
//  icon: Icon(Icons.location_city, color: Colors.white,),
  hintText: 'Enter city name',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 20
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0),),
    borderSide: BorderSide.none,
  ),
);