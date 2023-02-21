import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quicha/view/login_or_sign_up_screen/login_or_sign_up_screen.dart';
import 'package:quicha/view/sign_in_screen.dart';
import 'package:spring_button/spring_button.dart';

import '../../../ui/custom_style.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.appBarTheme,
      elevation: 2,
      centerTitle: true,
      //メール
      leading: Container(
          padding: EdgeInsets.only(left: size.width / 20),
          child: SpringButton(
            SpringButtonType.OnlyScale,
            Icon(
              Icons.mail,
              size: size.height / 25,
            ),
            onTap: () {},
          )),

      title: Container(
        height: size.height / 25,
        child: SvgPicture.asset(
          'assets/images/logo/quichaLogo.svg',
        ),
      ),
      actions: [
        //ベル
        // SpringButton(
        //   SpringButtonType.OnlyScale,
        //   Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Icon(
        //         Icons.notifications_outlined,
        //         size: size.height / 25,
        //       ),
        //       Positioned(
        //           right: 5,
        //           top: 18,
        //           child:
        //               //TODO:
        //               //通知を受け取ったら表示する
        //               Opacity(
        //                   opacity: 1,
        //                   child: Container(
        //                     height: 10,
        //                     width: 10,
        //                     decoration: BoxDecoration(
        //                         shape: BoxShape.circle, color: Colors.red),
        //                   )))
        //     ],
        //   ),
        //   onTap: () {},
        // ),
        SpringButton(
          SpringButtonType.OnlyScale,
          Icon(
            Icons.settings_rounded,
            size: size.height / 25,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        contentPadding: const EdgeInsets.all(10.0),
                        content: Container(
                          height: 100,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    // ログイン画面に遷移＋チャット画面を破棄
                                    await Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginOrSignUpScreen();
                                    }));
                                  },
                                  child: Text("ログアウト→")),
                              TextButton(
                                  onPressed: () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return SignInScreen();
                                    }));
                                  },
                                  child: Text(
                                    "メールアドレスと紐付ける",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),

        SizedBox(
          width: size.width / 30,
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
