import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/character_icons.dart';
import 'package:quicha/viewModel/new_account_viewmodel.dart';


class NewAccountScreen extends StatelessWidget {
  const NewAccountScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return


      ChangeNotifierProvider<NewAccountViewModel>(
          create: (context) => NewAccountViewModel(),
          child:

              Scaffold(
                  backgroundColor: CustomColor.selectIconBackground,
                body: _Body(size: size)
              )
      );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final NewAccountViewModel viewModel = Provider.of<NewAccountViewModel>(context);

    return
    SingleChildScrollView(
      child:
      Center(
        child:
        Padding(
          padding: EdgeInsets.all(size.height / 20),
          child:
          Column(
            children: [
              //アイコンを選択
              _SelectIcon(size: size),

              SizedBox(height: size.height / 10,),

              _InsertNickname(size: size),

              SizedBox(height: size.height / 10,),

              Container(
                height: size.height / 18,
                width: size.height / 9,
                child:
                ElevatedButton(onPressed: viewModel.nicknameController.text.isNotEmpty ? (){} : null, child:
                Text("決定", style: TextStyle(fontSize: size.height / 35),),
                  style: ElevatedButton.styleFrom(primary: CustomColor.darkBlue,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),


                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

class _InsertNickname extends StatelessWidget {
  const _InsertNickname({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final NewAccountViewModel viewModel = Provider.of<NewAccountViewModel>(context);

    return Column(
      children: [
        Text("ニックネームを入力", style: TextStyle(color: Colors.black,fontSize: size.height / 30),),

        SizedBox(height: size.height / 20,),

        Container(
          width:  size.width - 100,
          height: size.height / 15,
          padding: EdgeInsets.symmetric(horizontal: size.width / 10, vertical: size.height / 100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(),
              color: Colors.white
          ),
          child:
          TextField(
            keyboardType: TextInputType.text,
            maxLength: 10,
            controller: viewModel.nicknameController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: "ニックネーム",
              hintStyle: TextStyle(color: Colors.grey),


            ),
          ),
        )
      ],
    );
  }
}

class _SelectIcon extends StatelessWidget {
  const _SelectIcon({
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

        //アイコン
        Row(children: [
          Spacer(),
          _DefaultIcons(size: size, icons: CharacterIcons.default_human),
          _DefaultIcons(size: size, icons: CharacterIcons.default_bird),
          _DefaultIcons(size: size, icons: CharacterIcons.default_cat),
          Spacer(),

        ],),

        Row(children: [
          Spacer(),
          _DefaultIcons(size: size, icons: CharacterIcons.default_sheep),
          _DefaultIcons(size: size, icons: CharacterIcons.default_turtle),
          _DefaultIcons(size: size, icons: CharacterIcons.default_wolf),
          Spacer(),

        ],)

      ],
    );
  }
}

class _DefaultIcons extends StatelessWidget {
  const _DefaultIcons({
    Key? key,
    required this.size,
    required this.icons,
  }) : super(key: key);

  final Size size;
  final CharacterIcons icons;

  @override
  Widget build(BuildContext context) {

    final NewAccountViewModel viewModel = Provider.of<NewAccountViewModel>(context);

    return
    Padding(padding: EdgeInsets.symmetric(horizontal: size.width / 50, vertical: size.height / 70),
    child:
        InkResponse(
          onTap: () {
            viewModel.setIcon(icon: icons);
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
                Opacity( opacity: viewModel.selectedIcon == icons ? 0.7 : 0, child:
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
              Opacity(opacity: viewModel.selectedIcon == icons ? 0 : 0.7,
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

