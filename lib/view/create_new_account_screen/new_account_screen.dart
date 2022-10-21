import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/create_new_account_screen/widget/EnterButton.dart';
import 'package:quicha/view/create_new_account_screen/widget/select_icon.dart';
import 'package:quicha/view/create_new_account_screen/widget/nickname_text_field.dart';
import 'package:quicha/viewModel/new_account_viewmodel.dart';
import 'package:spring_button/spring_button.dart';


class NewAccountScreen extends StatelessWidget {
  const NewAccountScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
          GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child:
             _Body(size: size)
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
    
    var topHeight = MediaQuery.of(context).padding.top + kToolbarHeight;


    return
      Scaffold(
        appBar: AppBar(
          elevation: 0,

          backgroundColor: CustomColor.appBarTheme,
          title: Text("アバターを作る", style: TextStyle(fontFamily: 'Kodomo'),),
        ),
        resizeToAvoidBottomInset: false,
          backgroundColor: CustomColor.selectIconBackground,
          body:
          SingleChildScrollView(
            reverse: true,
              physics: NeverScrollableScrollPhysics(),
              child:
              Stack(
                children: [
                  Container(
                    height: size.height - topHeight,
                    width: size.width,
                    child:
                    Lottie.asset("assets/lottile/mountainBackground.json",
                        fit:BoxFit.fill),
                  ),
                  Center(
                    child:
                    Padding(
                      padding: EdgeInsets.all(size.height / 20),
                      child:
                      Column(
                        children: [
                          //アイコンを選択
                          SelectIcon(size: size),


                          //ニックネームを入力
                          NickNameTextField(size: size),


                          EnterButton(size: size)
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
      );
  }
}





