import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:popup_card/popup_card.dart';
import 'package:space_view/herodialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  var random = Random();

  var leftPadding = 0.0;
  var topPadding = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
    _controller.addListener(() {
      this.setState(() {});
    });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Timer.periodic(new Duration(seconds: 2), (timer) {
      leftPadding = random.nextDouble() == 0.0
          ? 1.0
          : random.nextDouble() * MediaQuery.of(context).size.width.toInt();
      topPadding = random.nextDouble() == 0.0
          ? 1.0
          : random.nextDouble() *
              random.nextInt(MediaQuery.of(context).size.height.toInt());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        child: Stack(
          children: [space(), star()],
        ),
        minScale: 0.2,
        maxScale: 3.0,
      ),
    );
  }

  Widget star() {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: topPadding),
      // padding: EdgeInsets.all(60),
      child: FadeTransition(
        opacity: _animation as Animation<double>,
        // child: InkWell(
        //   onTap: (){},
        //   child: Hero(
        //     tag: 'star',
        //     child: Icon(
        //       Icons.star,
        //       color: Colors.white,
        //       size: 100,
        //     ),
        //   ),
        // ),
        child: PopupItemLauncher(
          tag: 'test',
          child: const Icon(
            Icons.star,
            color: Colors.amber,
            size: 100,
          ),
          popUp: PopUpItem(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 2,
            tag: 'test',
            child: PopUpItemBody(),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: Hero(
            tag: 'star',
            child: Icon(
              Icons.star,
              color: Colors.yellow[300],
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget space() {
    return Image.network(
      'https://cdn.pixabay.com/photo/2016/03/09/15/18/stars-1246590_1280.jpg',
      fit: BoxFit.cover,
      width: 1000,
      height: 1000,
    );
  }
}
