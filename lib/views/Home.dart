import 'package:flutter/material.dart';
import 'package:hitotsu/views/insert_idea.dart';

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
  bool isPlaying = true;
  Animation<dynamic> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    final size = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FormIdea()));
                    },
                    child: AnimatedIcon(
                        icon: AnimatedIcons.add_event, progress: controller)))
          ],
        ),

      ],
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
