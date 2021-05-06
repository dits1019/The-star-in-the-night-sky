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
  // animation
  late AnimationController _controller;
  late Animation _animation;

  // random으로 위치 변경하기 위해서
  var random = Random();

  // 왼쪽과 오른쪽 패딩에 랜덤값 부여
  var leftPadding = 0.0;
  var topPadding = 0.0;

  @override
  void initState() {
    super.initState();
    // 애니메이션 실행
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          // 애니메이션 반복
          ..repeat(reverse: true);
    _controller.addListener(() {
      this.setState(() {});
    });

    // curve 추가
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // 일정 시간 후 랜덤으로 패딩값 변경
    Timer.periodic(new Duration(seconds: 2), (timer) {
      // 만약 랜덤값이 0이라면 1로 대체
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
      // 확대와 축소가 가능한 Viewer
      body: InteractiveViewer(
        child: Stack(
          children: [space(), star()],
        ),
        // 최소 축소
        minScale: 0.2,
        // 최대 확대
        maxScale: 3.0,
      ),
    );
  }

  // 랜덤 위치로 이동하는 별
  Widget star() {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: topPadding),
      child: FadeTransition(
        opacity: _animation as Animation<double>,
        child: PopupItemLauncher(
          tag: 'test',
          child: const Icon(
            Icons.star,
            color: Colors.amber,
            size: 100,
          ),
          // Dialog창 설정
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

  // 별 클릭 시 Dialog 표시
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

  // 배경
  Widget space() {
    return Image.network(
      'https://cdn.pixabay.com/photo/2016/03/09/15/18/stars-1246590_1280.jpg',
      fit: BoxFit.cover,
      width: 1000,
      height: 1000,
    );
  }
}
