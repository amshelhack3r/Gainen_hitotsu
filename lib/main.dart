import 'package:flutter/material.dart';
import 'package:hitotsu/models/idea.dart';
import 'package:hitotsu/views/Home.dart';

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
