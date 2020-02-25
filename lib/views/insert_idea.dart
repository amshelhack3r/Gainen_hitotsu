import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hitotsu/models/idea.dart';


// TODO refractor the page  to have even spacing
// TODO change state of icon chips. only active when one is selected
// TODO indepth validation of the form


class FormIdea extends StatefulWidget {
  FormIdea({Key key}) : super(key: key);

  @override
  _FormIdeaState createState() => _FormIdeaState();
}

class _FormIdeaState extends State<FormIdea> {
  //set a boolean to indicate if the form is valid
  //set state will be called on it to subit the form
  bool isValid = true;
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _usersController = TextEditingController();
  String _category = "android";
  var cardElevation = 11.0;
  var roundCorners = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)));

  //set style for the action chip
  bool clicked = true;

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

  List<String> selectedLanguages = List();

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
    return Scaffold(
        backgroundColor: Colors.white,
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
            decoration: BoxDecoration(),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  formField("NAME", Icons.text_fields, _nameController),
                  Text("ENTER DESCRIPTION"),
                  textArea(),
                  Card(
                    elevation: cardElevation,
                    shape: roundCorners,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("CATEGORIES"),
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
                  ),
                  formField("USERS", Icons.person_pin_circle, _usersController),
                  Wrap(
                    spacing: 7.0,
                    alignment: WrapAlignment.start,
                    children: getLanguages(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green[600],
                        onPressed:(){
                          validate();
                        },
                        child: (Text("submit")),
                      ),
                      RaisedButton(
                        color: Colors.amber[400],
                        onPressed: () {},
                        child: (Text("clear")),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget formField(
      String hint, IconData icon, TextEditingController controller) {
    return Card(
        elevation: cardElevation,
        shape: roundCorners,
        child: TextField(
          controller: controller,
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

  Widget textArea() {
    return Card(
        elevation: cardElevation,
        shape: roundCorners,
        child: TextField(
          controller: _descriptionController,
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

  List<Widget> getLanguages() {
    return languages
        .map((language) => ActionChip(
              label: Text(language),
              labelStyle: clicked ? TextStyle(color: Colors.green[300]) : null,
              onPressed: () {
                setState(() {
                  if (selectedLanguages.contains(language)) {
                    selectedLanguages.remove(language);
                  } else {
                    selectedLanguages.add(language);
                  }
                  clicked = !clicked;
                });
                print(selectedLanguages);
              },
            ))
        .toList();
  }

   validate() {
    String name = "";

    String description = _descriptionController.text;
    String users = _usersController.text;
    //check if there is an app name
    if (_nameController.text.isEmpty) {
      WordPair pair = generateWordPairs().first;
      name += pair.asPascalCase;
    } else {
      name += _nameController.text;
    }

    if (description.isEmpty) {
      setState(() {
        isValid = false;
      });
    }

    if (users.isEmpty) {
      setState(() {
        isValid = false;
      });
    }

    if (selectedLanguages.isEmpty) {
      setState(() {
        isValid = false;
      });
    }

    if (isValid) {
      Idea idea = Idea(name, description, _category, users, selectedLanguages);
      IdeaProvider ideaProvider = IdeaProvider();
      ideaProvider.insertIdea(idea).then((val) {
        Navigator.pop(context);
      }).catchError((err) {
        print(err);
      });
    }
  }
}
