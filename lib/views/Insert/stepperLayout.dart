import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hitotsu/models/idea.dart';
import 'package:hitotsu/utils/IdeaState.dart';
import 'package:hitotsu/utils/utils.dart';
import 'package:provider/provider.dart';

import '../Home.dart';

//TODO add validation to so as not to commit unless form is filled
//TODO go step further by implementing validation using the bloc pattern with transformers
//TODO Create final screen for reviewing the form and asking the user to commit changes
//TODO add notification manager to set notification for a project

class IdeaNameForm extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map ideaMap = Provider.of<IdeaState>(context).formState;
    print(ideaMap);
    if (ideaMap.containsKey("name")) {
      nameController.text = ideaMap['name'];
    }

    if (ideaMap.containsKey("about")) {
      aboutController.text = ideaMap['about'];
    }
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Consumer<IdeaState>(
                        builder: (BuildContext context, IdeaState state,
                                Widget child) =>
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  text: "IDEA NAME: ",
                                  style: labels(),
                                  children: [
                                    TextSpan(
                                        text: ideaMap.containsKey("name")
                                            ? ideaMap['name']
                                            : state.ideaName,
                                        style: namingHeaders())
                                  ]),
                            )),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Consumer<IdeaState>(
                        builder: (_, state, child) => RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  text: "ABOUT: ",
                                  style: labels(),
                                  children: [
                                    TextSpan(
                                        text: ideaMap.containsKey("about")
                                            ? ideaMap['about']
                                            : state.ideaAbout,
                                        style: namingHeaders())
                                  ]),
                            )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        Provider.of<IdeaState>(context, listen: false)
                            .ideaName = val;
                      },
                      decoration: textFields(Icons.assignment, "CHANGE NAME"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    TextField(
                      onChanged: (val) {
                        Provider.of<IdeaState>(context, listen: false)
                            .ideaAbout = val;
                      },
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
                            var name =
                                Provider.of<IdeaState>(context, listen: false)
                                    .ideaName;
                            var about =
                                Provider.of<IdeaState>(context, listen: false)
                                    .ideaAbout;

                            Provider.of<IdeaState>(context, listen: false)
                                .mapIdea("name", name);
                            Provider.of<IdeaState>(context, listen: false)
                                .mapIdea("about", about);
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
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ideaMap = Provider.of<IdeaState>(context).formState;
    print(ideaMap);
    if (ideaMap.containsKey("description")) {
      descriptionController.text = ideaMap['description'];
    }
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
                    onChanged: (val) {
                      Provider.of<IdeaState>(context, listen: false)
                          .description = val;
                    },
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
                            ideaMap['description'] =
                                Provider.of<IdeaState>(context, listen: false)
                                    .description;
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
  List<String> languages = getLanguagesStack();
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
    Map<String, dynamic> ideaMap = Provider.of<IdeaState>(context).formState;
    print(ideaMap);

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "CATEGORIES",
                      style: namingHeaders(),
                    ),
                    Consumer<IdeaState>(
                      builder: (_, state, child) => DropdownButton(
                          value: state.category,
                          items: categories,
                          onChanged: (value) {
                            Provider.of<IdeaState>(context, listen: false).category = value;
                          }),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  "USERS INVOLVED",
                  style: namingHeaders(),
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      Provider.of<IdeaState>(context, listen: false).users = val;
                      print(Provider.of<IdeaState>(context, listen: false).formState);
                    },
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
                Consumer<IdeaState>(
                    builder: (_, state, child) => Wrap(
                          spacing: 3.0,
                          children: buildChips(state.selectedLanguages, context),
                        )),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  "LANGUAGES",
                  style: namingHeaders(),
                ),
                Wrap(
                  spacing: 7.0,
                  alignment: WrapAlignment.start,
                  children: getLanguages(context),
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
                          ideaMap['category'] =
                              Provider.of<IdeaState>(context, listen: false)
                                  .category;
                          ideaMap['users'] =
                              Provider.of<IdeaState>(context, listen: false)
                                  .users;
                          ideaMap['languages'] =
                              Provider.of<IdeaState>(context, listen: false)
                                  .selectedLanguages;

                          Provider.of<IdeaState>(context, listen: false)
                              .formState = ideaMap;

                          var provider = IdeaProvider();
                          provider.insertIdea(Idea.fromMap(ideaMap)).then((val){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          });
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

  List<Widget> getLanguages(BuildContext context) {
    return languages
        .map((language) => ActionChip(
              elevation: 11,
              onPressed: () {
                Provider.of<IdeaState>(context, listen: false).language =
                    language;
              },
              label: Text(language),
            ))
        .toList();
  }

  List<Widget> buildChips(Set<String> selectedLanguages, BuildContext context) {
    return selectedLanguages
        .map((language) => Chip(
              label: Text(language),
              backgroundColor: Colors.blueAccent,
              labelStyle: TextStyle(color: Colors.white70),
              deleteIcon: Icon(Icons.cancel),
              deleteIconColor: Colors.redAccent,
              onDeleted: () {
                Provider.of<IdeaState>(context, listen: false).removeLanguage(language);
              },
            ))
        .toList();
  }
}