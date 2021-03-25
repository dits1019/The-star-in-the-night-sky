import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpItemBody extends StatelessWidget {
  const PopUpItemBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.amber[600],
            size: 100,
          ),
          Text('별(Star)'),
          Center(
            child: Text('스스로의 중력에 의해 묶인 밝은 플라스마로 이루어진 꼴의 천체를 말한다.'),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
                '문자나 도형으로 표기할 때는  *와 ☆같은 \n5각이나 6각으로 뾰족한 모양으로 사용하기도 한다.\n이건 밤하늘에 밝게 빛나는 별에서 반짝하고 퍼져나오는 빛살을 추상화한 것으로 보인다.'),
          )
        ],
      ),
    );
  }
}
