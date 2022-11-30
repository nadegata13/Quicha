import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/input_phone_number_screen/input_phone_number_screen.dart';
import 'package:rive/rive.dart';
import 'package:spring_button/spring_button.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body:
      Stack(
        children: [

          SvgPicture.asset("assets/images/background/sign_background.svg", fit: BoxFit.fill,),
          Align(
            alignment: Alignment(0, -0.6),
            child: Container(
              height: size.height / 5,
              child: Column(
                children: [
                  SizedBox(
                      height: size.height / 10,

                      child: RiveAnimation.asset('assets/rive/new_file.riv')
                  ),
                  SizedBox(height: size.height / 50,),
                  Text("クイズで盛り上がろう",
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),


          Align(alignment: Alignment.center,
            child: SizedBox(
                height: size.height / 2,
                child: Lottie.asset("assets/lottile/chat_animation.json",)),
          ),
          Align(alignment: Alignment.bottomCenter,
            child:
            Container(
              height: size.height / 3,
              margin: EdgeInsets.only(bottom: size.height / 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  SignButton(size: size, isSignIn: true, title: "ログイン・新規登録", onPressed: () {
                    //
                    // （1） 指定した画面に遷移する
                    Navigator.push(context, MaterialPageRoute(
                      // （2） 実際に表示するページ(ウィジェット)を指定する
                        builder: (context) => InputPhoneNumberScreen()
                    ));
                  },),
                  SizedBox(height: size.height / 20,),
                  SignButton(size: size, isSignIn: false, title: "お問い合わせ", onPressed: () {
                    //
                  },),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  const SignButton({
    Key? key,
    required this.isSignIn,
    required this.size,
    required this.title, required this.onPressed,

  }) : super(key: key);

  final Size size;
  final bool isSignIn;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return
      SpringButton(SpringButtonType.OnlyScale,

        Container(
          width: size.width - 100,
          height: size.height / 18,
          padding: EdgeInsets.symmetric(horizontal: size.width / 25),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 2), // changes position of shadow
            ),],
            borderRadius: BorderRadius.circular(15),
            color: isSignIn ? Colors.white : Colors.black,
          ),
          child:
          Stack(
            children: [
              Align(alignment: Alignment.centerLeft,child:
              Icon(isSignIn ? Icons.person : Icons.email_rounded, color: isSignIn ? Colors.black : Colors.white,size: size.height / 25,)),
              Align(
                  alignment: Alignment.center,
                  child:
                  Text(title, style: TextStyle(color: isSignIn? Colors.black : Colors.white,
                      fontSize: size.height / 40,
                    fontFamily: 'MPlus'
                  ),)
              )
            ],
          )
          ,
        ),
        onTap: onPressed,
        scaleCoefficient: 0.9,
      );
  }
}
