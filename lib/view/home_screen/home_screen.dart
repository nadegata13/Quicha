import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/home_screen/widget/app_bar.dart';
import 'package:quicha/view/home_screen/widget/matching_button.dart';
import 'package:quicha/view/home_screen/widget/user_icon.dart';
import 'package:quicha/view/home_screen/widget/user_life.dart';
import 'package:quicha/view/home_screen/widget/user_nickname.dart';
import 'package:spring_button/spring_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return _Body(size: size);
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
    return Scaffold(
        backgroundColor: CustomColor.backgroundYellow,
        appBar: HomeAppBar(size: size),
        body: Center(
            child: Column(
          children: [
            //ライフ
            UserLife(size: size),

            SizedBox(
              height: size.height / 30,
            ),

            //アイコン
            UserIcon(size: size),

            //ニックネーム
            UserNickName(size: size),

            SizedBox(
              height: size.height / 25,
            ),

            //エントリーボタン
            MatchingButton(size: size),

            SizedBox(
              height: size.height / 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "クイズ作成",
                      style: GoogleFonts.mochiyPopOne(
                          color: CustomColor.thinBlack,
                          fontSize: size.height / 50),
                    ),
                    SpringButton(
                      SpringButtonType.OnlyScale,
                      Container(
                          height: size.height / 10,
                          child: SvgPicture.asset(
                              "assets/images/system/makeQuiz.svg")),
                      onTap: () {
                        _showDialogNothing(context: context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width / 10,
                ),
                Column(
                  children: [
                    Text(
                      "SHOP",
                      style: GoogleFonts.mochiyPopOne(
                          color: CustomColor.thinBlack,
                          fontSize: size.height / 50),
                    ),
                    SpringButton(
                      SpringButtonType.OnlyScale,
                      Container(
                          height: size.height / 10,
                          child: SvgPicture.asset(
                              "assets/images/system/shop.svg")),
                      onTap: () {
                        _showDialogNothing(context: context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        )));
  }

  void _showDialogNothing({required context}) {
    showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            children: [
              Container(
                  height: 100, width: 100, child: Center(child: Text("乞うご期待！")))
            ],
          );
        }));
  }
}
