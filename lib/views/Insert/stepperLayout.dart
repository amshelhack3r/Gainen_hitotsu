import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hitotsu/utils/utils.dart';

//TODO add provider to share state between screens
//TODO add notification manager to set notification for a project
//TODO add more languages
//TODO Save to DB

class IdeaNameForm extends StatelessWidget {
  TextEditingController nameController, aboutController;
  String namePlaceholder, aboutPlaceHolder;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "IDEA NAME: ",
                          style: labels(),
                          children: [
                            TextSpan(
                                text: namePlaceholder, style: namingHeaders())
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text:
                          TextSpan(text: "ABOUT: ", style: labels(), children: [
                        TextSpan(text: aboutPlaceHolder, style: namingHeaders())
                      ]),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      onChanged: (val) {},
                      decoration: textFields(Icons.assignment, "CHANGE NAME"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    TextField(
                      onChanged: (val) {},
                      controller: aboutController,
                      decoration: textFields(Icons.description, "CHANGE ABOUT"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Material(
                      elevation: 11,
                      shape: CircleBorder(),
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        IdeaDescriptionForm()));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 11,
                      shape: CircleBorder(),
                      color: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

class IdeaDescriptionForm extends StatelessWidget {
  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.description,
                  size: 50,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Some Description",
                        hintStyle: TextStyle(
                            fontSize: 40, fontStyle: FontStyle.italic)),
                    controller: descriptionController,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 40),
                    maxLines: 1000,
                    minLines: 200,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Material(
                      elevation: 11,
                      shape: CircleBorder(),
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IdeaMiscForm()));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 11,
                      shape: CircleBorder(),
                      color: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

class IdeaMiscForm extends StatelessWidget {
  List<String> languages = [
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
  String _category = "android";

  List<String> selectedLanguages = [];

  List<DropdownMenuItem> categories = [
    DropdownMenuItem(value: "android", child: Text("Android Application")),
    DropdownMenuItem(value: "webapp", child: Text("Web Application")),
    DropdownMenuItem(value: "desktop", child: Text("Desktop Application")),
    DropdownMenuItem(value: "website", child: Text("Website")),
    DropdownMenuItem(value: "ios", child: Text("IOS Application")),
    DropdownMenuItem(value: "none", child: Text("Decide Later")),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "CATEGORIES",
                      style: namingHeaders(),
                    ),
                    DropdownButton(
                        value: _category,
                        items: categories,
                        onChanged: (value) {}),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black26,
                        ),
                        hintText: "USERS",
                        hintStyle: TextStyle(color: Colors.black87),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40.0)),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 15.0))),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Wrap(
                  spacing: 3.0,
                  children: buildChips(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 7.0,
                    alignment: WrapAlignment.start,
                    children: getLanguages(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () {
                          print("yes");
                        },
                        color: Colors.blueAccent,
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        elevation: 11,
                        label: Text(
                          "finish",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 11,
                      shape: CircleBorder(),
                      color: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  List<Widget> getLanguages() {
    return languages
        .map((language) => ActionChip(
              elevation: 11,
              onPressed: () {
                if (!selectedLanguages.contains(language)) {}
              },
              label: Text(language),
            ))
        .toList();
  }

  List<Widget> buildChips() {
    return selectedLanguages
        .map((language) => Chip(
              label: Text(language),
              backgroundColor: Colors.blueAccent,
              labelStyle: TextStyle(color: Colors.white70),
              deleteIcon: Icon(Icons.cancel),
              deleteIconColor: Colors.redAccent,
              onDeleted: () {},
            ))
        .toList();
  }
}
