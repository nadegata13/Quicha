import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../ui/character_icons.dart';
import '../../../viewModel/new_account_viewmodel.dart';

class SelectIcon extends StatelessWidget {
  const SelectIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //アイコンを選択
        Padding(padding: EdgeInsets.only(top: size.height / 20 , bottom: size.height / 50),
          child:
          Text("アイコンを選択", style: TextStyle(color: Colors.black,fontSize: size.height / 30),),
        ),

        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //カラム数
          ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6, //要素数
          itemBuilder: (context, index) {
            //要素を戻り値で返す
            return Container(
                child: _DefaultIcons(size: size, icons: CharacterIcons.getIcon(index),)
            );
          },
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class _DefaultIcons extends ConsumerWidget {
  const _DefaultIcons({
    Key? key,
    required this.size,
    required this.icons,
  }) : super(key: key);

  final Size size;
  final CharacterIcons icons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final watchProvider = ref.watch(newAccountProvider);
    final read = ref.read(newAccountProvider);


    return
      Padding(padding: EdgeInsets.symmetric(horizontal: size.width / 50, vertical: size.height / 70),
          child:
          InkResponse(
              onTap: () {
                read.setIcon(icon: icons);
              },
              child:
              Stack(
                alignment: Alignment.center,
                children: [
                  //選択された時の光
                  Container(
                    width: size.height / 10,
                    height: size.height / 10,
                    child:
                    Opacity( opacity: watchProvider.selectedIcon == icons ? 0.7 : 0, child:
                    //ぼやぼや
                    CustomPaint(foregroundPainter: _CircleBlurPainter(circleWidth: 4, blurSigma: 1.0)),
                    ),
                  ),

                  //アイコンイラスト
                  Container(
                    height: size.height / 10,
                    width: size.height / 10,
                    child: SvgPicture.asset(icons.getPath),
                  ),

                  //選択されてない時の黒フィルター
                  Opacity(opacity: watchProvider.selectedIcon == icons ? 0 : 0.7,
                    child:
                    Container(
                      height: size.height / 10,
                      width: size.height / 10,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle
                      ),
                    ),
                  ),

                ],
              )
          )
      );
  }
}

class _CircleBlurPainter extends CustomPainter {

  _CircleBlurPainter({required this.circleWidth, required this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
