import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gainen Apuri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: (){},),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(

        ),
        body: Center(child: Text("HELLO WORLD ")
      ),
    )
    );
  }
}

