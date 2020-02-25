import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hitotsu/views/insert_idea.dart';
import 'package:hitotsu/models/idea.dart';
import 'package:date_format/date_format.dart';

// TODO add rounded corners to card listview
// TODO Check for a placeholder for colors to switch each times a user taps
// TODO change the stack widget to a description of the selected card
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
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  IdeaProvider provider;
  bool isPlaying = true;
  Animation<dynamic> animation;
  AnimationController controller;

  List<Idea> ideasList;

  showIdeas() async {
    ideasList = await provider.getIdeas();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = IdeaProvider(); /**/

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    animation = Tween().animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        new Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;
          controller?.forward();
        });
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        stack(),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        getIdeas()
      ],
    );
  }

  Widget stack() {
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
        Positioned(
            top: 30,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
              color: Colors.white70,
            )),
        Positioned(
            bottom: 0,
            right: size * 0.5,
            child: FloatingActionButton(
                hoverElevation: 5.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FormIdea()));
                },
                child: AnimatedIcon(
                    icon: AnimatedIcons.add_event, progress: controller)))
      ],
    );
  }

  Widget getIdeas() {
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => FormIdea()));
                          },
                          label: Text("ADD NEW", style: TextStyle(fontSize: 20),),
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
                      print(idea);
                      var developed = idea.developed;
                      var period = idea.period;
                      return Container(
                           margin: EdgeInsets.only(left: 50, top: 80, bottom: 80),
                          child: Card(
                            color: Colors.red,
                            elevation: 11,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(idea.name),
                                Text(idea.description),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Developed $developed'),
                                    Text('Period $period')
                                  ],
                                )
                              ],
                            ),
                          ),
                      );
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

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _onPressed() {
    setState(() {
      print("helllo");
      isPlaying = !isPlaying;
      isPlaying ? controller.forward() : controller.reverse();
    });
  }
}
