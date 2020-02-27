import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyStepper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _index;

  List<Widget> steppers = [
    nameWidget(),
    aboutWidget(),
    descriptionWidget(),
    categoryWidget(),
    stackWidget(),
    initialWidget()
  ];

  Widget activeWidget;

  @override
  initState(){
    _index = 0;
    activeWidget = steppers[_index];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                activeWidget,
                RaisedButton(
                  child: Text("next widget"),
                  onPressed: () {
                    setState(() {
                      _index += 1;


                    });
                  },
                )
              ],
            )),
      ),
    );
  }

  Widget formField() {
    return SizedBox(
        height: double.infinity,
        child: TextField(
          style: TextStyle(fontSize: 80),
          maxLines: 500,
          minLines: 200,
        ));
  }

  static Widget nameWidget() {
    return Center(
      child: Text("name"),
    );
  }

  static Widget aboutWidget() {
    return Center(
      child: Text("about"),
    );
  }

  static Widget descriptionWidget() {
    return Center(
      child: Text("description"),
    );
  }

  static Widget categoryWidget() {
    return Center(
      child: Text("category"),
    );
  }

  static Widget stackWidget() {
    return Center(
      child: Text("stack"),
    );
  }

  static Widget initialWidget() {
    return Center(
      child: Text("initial"),
    );
  }
}
