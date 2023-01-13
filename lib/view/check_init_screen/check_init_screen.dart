import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicha/view/login_or_sign_up_screen/login_or_sign_up_screen.dart';

import '../../repository/socket_client.dart';
import '../../ui/custom_style.dart';

class CheckInitSCreen extends StatefulWidget {
  @override
  _CheckInitSCreenState createState() => _CheckInitSCreenState();

}

class _CheckInitSCreenState extends State<CheckInitSCreen> {
  @override
  Widget build(BuildContext context) {

    @override
    void initState(){
      final _socketClient = SocketClient.instance.socket!;
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      _socketClient.clearListeners();

      if(_firebaseAuth.currentUser == null) {
        //firebase authにログインしていない場合
        Navigator.pushReplacement(context,
            MaterialPageRoute(
              // （2） 実際に表示するページ(ウィジェット)を指定する
                builder: (context) =>  LoginOrSignUpScreen()

            ));
      } else {
        // _socketClient.emit("checkExitAccount", ç);
      }

      super.initState();
    }

    final Size size = MediaQuery.of(context).size;
    return
      Container(
        height: size.height,
        width: size.width,
        color: CustomColor.backgroundYellow,
      );
  }
}


