import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyStepper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  Map<String, String> ideaMap;

  Widget activeWidget;
  Widget previousWidget;
  TextEditingController nameController, aboutController, descriptionController;
  String namePlaceholder, aboutPlaceHolder, descPlaceholder;

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

  List<String> selectedLanguages;

  List<DropdownMenuItem> categories = [
    DropdownMenuItem(value: "android", child: Text("Android Application")),
    DropdownMenuItem(value: "webapp", child: Text("Web Application")),
    DropdownMenuItem(value: "desktop", child: Text("Desktop Application")),
    DropdownMenuItem(value: "website", child: Text("Website")),
    DropdownMenuItem(value: "ios", child: Text("IOS Application")),
    DropdownMenuItem(value: "none", child: Text("Decide Later")),
  ];

  @override
  initState() {
    super.initState();
    //controllers for texts
    nameController = TextEditingController();
    aboutController = TextEditingController();
    descriptionController = TextEditingController();

    //map for saving to the database
    ideaMap = {};

    //placeholders or hints
    namePlaceholder = WordPair.random().asPascalCase;
    aboutPlaceHolder = "An App About Birds 🐦";
    descPlaceholder = "What The App/System Does";

    activeWidget = nameWidget();

    selectedLanguages = List();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(margin: EdgeInsets.all(20), child: activeWidget),
      ),
    );
  }

  Widget nameWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(text: "IDEA NAME: ", style: labels(), children: [
                TextSpan(text: namePlaceholder, style: namingHeaders())
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(text: "ABOUT: ", style: labels(), children: [
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
              onChanged: (val) {
                setState(() {
                  namePlaceholder = val;
                  activeWidget = nameWidget();
                });
              },
              decoration: textFields(Icons.assignment, "CHANGE NAME"),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  aboutPlaceHolder = val;
                  activeWidget = nameWidget();
                });
              },
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
                    setState(() {
                      ideaMap["name"] = nameController.text;
                      ideaMap['about'] = aboutController.text;
                      activeWidget = descriptionWidget();
                    });
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
    );
  }

  Widget descriptionWidget() {
    setState(() {
      previousWidget = nameWidget();
      activeWidget = descriptionWidget();
    });
    return Column(
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
                hintStyle:
                    TextStyle(fontSize: 40, fontStyle: FontStyle.italic)),
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
                    setState(() {
                      ideaMap["desc"] = descriptionController.text;
                      activeWidget = finalWidget();
                    });
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
                    setState(() {
                      activeWidget = previousWidget;
                    });
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
    );
  }

  Widget finalWidget() {
    setState(() {
      previousWidget = descriptionWidget();
    });
    return Column(
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
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                }),
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
                contentPadding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 15.0))),
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
                onPressed: () {},
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
                    setState(() {
                      activeWidget = previousWidget;
                    });
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
    );
  }

  List<Widget> getLanguages() {
    return languages
        .map((language) => ActionChip(
              elevation: 11,
              onPressed: () {
                if (!selectedLanguages.contains(language)) {
                  setState(() {
                    selectedLanguages.add(language);
                    activeWidget = finalWidget();
                  });
                }
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
              onDeleted: () {
                setState(() {
                  selectedLanguages.remove(language);
                  activeWidget = finalWidget();
                });
              },
            ))
        .toList();
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
}