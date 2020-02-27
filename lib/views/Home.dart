import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hitotsu/views/insert_idea.dart';
import 'package:hitotsu/models/idea.dart';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:hitotsu/views/insert_idea2.dart';

// TODO change scaffold color to the color of the card
// TODO create a page to view the ideas in depth
// TODO use hhero image transistion to and from the page
// TODO create an edit option to update or delete an idea
// TODO show app to people
// TODO refractor changes people make
// TODO upload app to the appstore

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyStepper()));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  IdeaProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = IdeaProvider(); /**/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _mainHeader(),
        _bodyContent()
      ],
    );
  }

  Widget _mainHeader() {
    final size = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          height: size - 0.25 * size,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)),
            child: Image.asset(
              'data_repo/images/overview.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyContent() {
    return Expanded(
      child: FutureBuilder(
          initialData: null,
          future: provider.getIdeas(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            Widget _body;
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                _body = Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 220,
                        height: 80,
                        child: RaisedButton.icon(
                          elevation: 11,
                          icon: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          ),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormIdea()));
                          },
                          label: Text(
                            "ADD NEW",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                _body = ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Idea idea = snapshot.data[index];
                      List<Widget> getLanguages() {
                        return idea.languages
                            .map((language) => ActionChip(

                                  label: Text(language),
                                  labelStyle:
                                      TextStyle(color: Colors.green[300]),
                                  onPressed: () {},
                                ))
                            .toList();
                      }

                      print(idea);
                      var developed = idea.developed;
                      var period = idea.period;
                      return Container(
                        width: 300,
                          margin:
                              EdgeInsets.only(left: 50, top: 20, bottom: 80),
                          child: Material(
                            elevation: 11,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  smallPadding(),
                                  RichText(
                                    text: TextSpan(
                                        text: "IDEA: ",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text: idea.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28,
                                                  fontFamily: 'nunito'))
                                        ]),
                                  ),
                                  smallPadding(),
                                  Text(
                                    "APPLICATION ABOUT BIRDS",
                                    style: TextStyle(
                                        fontFamily: 'nunito',
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                    textWidthBasis:
                                        TextWidthBasis.longestLine,
                                  ),
                                  smallPadding(),
                                  Text(
                                    idea.trimDescription(),
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'nunito',
                                      color: Colors.white70,
                                    ),
                                  ),
                                  smallPadding(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("TYPE"),
                                          Text(idea.category)
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("USERS"),
                                          Text(idea.users)
                                        ],
                                      )
                                    ],
                                  ),
                                  smallPadding(),
                                  Wrap(
//                                    alignment: WrapAlignment.center,
                                    spacing: 5.0,
                                    runAlignment: WrapAlignment.start,
                                    runSpacing: 3,
                                    children: getLanguages(),
                                  )
                                ],
                              ),
                            ),
                          ));
                    });
              }
            } else if (snapshot.hasError) {
              _body = Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              _body = Center(
                child: CircularProgressIndicator(),
              );
            }

            return _body;
          }),
    );
  }

  Widget smallPadding() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
    );
  }
}
