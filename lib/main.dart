import 'package:flutter/material.dart';
import 'package:hitotsu/models/idea.dart';
import 'package:hitotsu/views/Home.dart';

// TODO add firebase integration for saving ideas
// TODO smart application architecture to save to local db when no internet or update firebase storage
// TODO Firebase authentication to register new users

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var data = new IdeaProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gainen Apuri',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white70,
          fontFamily: "Nunito"
        ),
        home: HomePage()
    );
  }
}
