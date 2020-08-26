import 'package:flutter/material.dart';
import 'package:hitotsu/models/idea.dart';
import 'package:hitotsu/utils/IdeaState.dart';
import 'package:hitotsu/views/Home.dart';

// TODO add firebase integration for saving ideas
// TODO smart application architecture to save to local db when no internet or update firebase storage
// TODO Firebase authentication to register new users
// TODO show notifications once in a while
// TODO share an idea to multiple social media

import 'dart:math';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var data = new IdeaProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new IdeaState(),
      child: MaterialApp(
          title: 'Gainen Apuri',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white70,
            fontFamily: "Nunito",
            backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ),
          home: HomePage()
      ),
    );
  }

}
