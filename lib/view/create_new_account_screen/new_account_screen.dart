import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/create_new_account_screen/widget/select_icon.dart';
import 'package:quicha/view/create_new_account_screen/widget/nickname_text_field.dart';
import 'package:quicha/viewModel/new_account_viewmodel.dart';


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
          backgroundColor: CustomColor.selectIconBackground,
          body:
          Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child:
                Lottie.asset("assets/lottile/mountainBackground.json",
                fit:BoxFit.fitHeight),
              ),
              SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child:
                  Center(
                    child:
                    Padding(
                      padding: EdgeInsets.all(size.height / 20),
                      child:
                      Column(
                        children: [
                          //アイコンを選択
                          SelectIcon(size: size),

                            SizedBox(height: size.height / 10,),

                          NickNameTextField(size: size),

                            SizedBox(height: size.height / 10,),

                          Container(
                              height: size.height / 18,
                              width: size.height / 9,
                              child:
                              EnterButton(size: size)
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          )
      );
  }
}

class EnterButton extends ConsumerWidget {
  const EnterButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(onPressed: ref.read(newAccountProvider).nicknameController.text.isNotEmpty ? (){} : null, child:
    Text("決定", style: TextStyle(fontSize: size.height / 35),),
      style: ElevatedButton.styleFrom(primary: CustomColor.darkBlue,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),


      ),
    );
  }
}




