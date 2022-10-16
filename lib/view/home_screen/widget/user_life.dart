import 'package:flutter/cupertino.dart';

import '../../../test_data.dart';

class UserLife extends StatelessWidget {
  const UserLife({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width / 2,
        child:
        Column(
          children: [

            //ライフ復活時間
            Padding(padding: EdgeInsets.symmetric(vertical: size.height / 50),
              child:
              Opacity(opacity: 1,
                child:
                Align(alignment: Alignment(0.9,0),
                  child: Text(TestData.currentTime),
                ),
              ),
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //ライフ（引数の数は緑色のハートの数)
              children: _restLifes(TestData.fillLifeCount),
            )
          ],
        )
    );
  }

  List<Widget> _restLifes(int lifeCount) {

    final fillCount = 5;
    List<Widget> lifes = [];

    //fillLife
    for(int i = 0; i < lifeCount; i++){
      lifes.add(_Lifes(size: size, isFill: true));
    }
    //blankLife
    for(int i = 0; i < fillCount - lifeCount; i++){
      lifes.add(_Lifes(size: size, isFill: false));
    }




    return lifes;
  }
}

class _Lifes extends StatelessWidget {
  const _Lifes({
    Key? key,
    required this.size,
    required this.isFill,
  }) : super(key: key);

  final Size size;
  final bool isFill;

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
          flex: 1,
          child:
          Container(
            height: size.height / 30,
            child:
            Image.asset(isFill ? "assets/images/system/lifeFill.png" : "assets/images/system/lifeBlank.png"),
          )
      );
  }
}
