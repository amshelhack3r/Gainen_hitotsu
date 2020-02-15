import 'package:flutter/material.dart';

class FormIdea extends StatefulWidget {
  FormIdea({Key key}) : super(key: key);

  @override
  _FormIdeaState createState() => _FormIdeaState();
}

class _FormIdeaState extends State<FormIdea> {
  static var _valueController = TextEditingController();
  int counter = 0;
  List<Step> steps = [
    Step(
        title: Text("Idea Name"),
        subtitle: Text("Enter name of Idea"),
        content: formField("name", Icons.text_fields)),
    Step(
      title: Text("Idea Description"),
      subtitle: Text("Enter some description of Idea"),
      content: textArea(),
    ),
    Step(
        title: Text("Category"),
        content: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 11,
          child: Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Column(
              children: <Widget>[
                Text("Categories"),
                DropdownButton(items: categories, onChanged: (value) {}),
              ],
            ),
          ),
        )),
    Step(),

  ];
  static List<String> languages = [
    "HTML",
    "CSS",
    "PHP",
    "JAVASCRIPT",
    "PYTHON",
    "RUBY",
    "JAVA",
    "KOTLIN",
    "FLUTTER",
    "DART",
    "MYSQL",
    "FIREBASE",
    "MONGODB",
    "REACT",
    "NODEJS"
  ];
  
  static List<DropdownMenuItem> categories = [
    DropdownMenuItem(value: "android", child: Text("Android Application")),
    DropdownMenuItem(value: "webapp", child: Text("Web Application")),
    DropdownMenuItem(value: "desktop", child: Text("Desktop Application")),
    DropdownMenuItem(value: "website", child: Text("Website")),
    DropdownMenuItem(value: "ios", child: Text("IOS Application")),
    DropdownMenuItem(value: 0, child: Text("Decide Later")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NEW IDEA"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          child: Stepper(
            type: StepperType.vertical,
            steps: steps,
            currentStep: counter,
            onStepTapped: (index) {
              setState(() {
                counter = index;
              });
            },
            onStepContinue: () {
              if (counter < steps.length - 1) {
                setState(() {
                  counter += 1;
                });
              }
            },
          ),
        ));
  }

  static Widget formField(String hint, IconData icon) {
    return Card(
        elevation: 11,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: TextField(
          controller: _valueController,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.black26,
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black26),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)),
        ));
  }

  static Widget textArea() {
    return Card(
        elevation: 11,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: TextField(
          controller: _valueController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(30.0, 45.0, 30.0, 45.0),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
          ),
        ));
  }
}
