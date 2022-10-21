import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:spring_button/spring_button.dart';
import '../../../viewModel/new_account_viewmodel.dart';

class EnterButton extends ConsumerWidget {
  const EnterButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchProvider = ref.watch(newAccountProvider);
    return
      Opacity(opacity: 0.9,

          child:
          SpringButton(
            SpringButtonType.OnlyScale,

            Container(
                height: size.height / 6,
                child: Lottie.asset("assets/lottile/startButton.json",
                    fit: BoxFit.fitHeight
                )
            ),
            onTap: () {
              if(ref.watch(newAccountProvider).nicknameController.text.isEmpty) {return;}
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0))),
                      backgroundColor: CustomColor.thinBlue,
                      contentPadding: EdgeInsets.only(top: 10.0),
                      content: Container(
                        width: 300.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: size.height / 30
                            ),
                            Container(
                              height: size.height / 4,
                              width: size.height / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                              ),
                              padding: EdgeInsets.all(size.height / 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: SvgPicture.asset(watchProvider.selectedIcon.getPath, fit: BoxFit.fitHeight,),
                                    height: size.height / 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: size.height / 100),
                                    child:
                                    Text(watchProvider.nicknameController.text,
                                      style: TextStyle(fontSize: size.height / 50,
                                          fontWeight: FontWeight.w700),)
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: BoxDecoration(
                                color: CustomColor.thinBlue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: Column(
                                children: [

                                  Text("このアバターで設定しますか？", style: TextStyle(
                                    fontSize: size.height / 70,
                                    color: Colors.black54

                                  ),),
                                  SizedBox(height: size.height / 100,),
                                  Text("※登録後も変更ができます", style: TextStyle(
                                      fontSize: size.height / 80,
                                      color: Colors.black54

                                  ),),
                                  SizedBox(height: size.height / 30,),
                                  Container(
                                      child:
                                      SpringButton(SpringButtonType.OnlyScale,
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: size.height / 50),
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.green,
                                          ),
                                          child: Text("はじめる", style: TextStyle(color: Colors.white,
                                              fontSize: size.height / 50, fontWeight: FontWeight.w500),),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop(); // To close the dialog
                                        },
                                      )
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
              print(ref.watch(newAccountProvider).nicknameController.text);



            },
          )
      );

  }
}
