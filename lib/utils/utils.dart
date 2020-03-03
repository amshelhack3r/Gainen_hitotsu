import 'package:flutter/material.dart';

LinearGradient getCustomGradient() {
  // Define a Linear Gradient
  return new LinearGradient(
      colors: [Colors.pink, Colors.blueAccent],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.6, 0.0),
      stops: [0.0, 0.6],
      tileMode: TileMode.clamp);
}

TextStyle getCustomFontTextStyle() {
  // text style which defines a custom font
  return const TextStyle(
      // set color of text
      color: Colors.black,
      // set the font family as defined in pubspec.yaml
      fontFamily: 'Nunito',
      // set the font weight
      fontWeight: FontWeight.w400,
      // set the font size
      fontSize: 36.0);
}

//styling
TextStyle namingHeaders() {
  return TextStyle(
      color: Colors.blueAccent,
      fontFamily: "Nunito",
      fontWeight: FontWeight.bold,
      fontSize: 30);
}

TextStyle labels() {
  return TextStyle(
      color: Colors.black87, fontSize: 20, fontFamily: ".SF UI Text");
}

InputDecoration textFields(IconData data, String hint) {
  return InputDecoration(
      prefixIcon: Icon(
        data,
        color: Colors.black26,
      ),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black26),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(40.0)),
      contentPadding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 35.0));
}