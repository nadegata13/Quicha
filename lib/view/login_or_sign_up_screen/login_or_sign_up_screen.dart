import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/input_phone_number_screen/input_phone_number_screen.dart';
import 'package:quicha/viewModel/login_viewmodel/login_notifier.dart';
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

          //メーr
          Align(alignment: Alignment.topLeft,
          child: IconButton(icon: Icon(Icons.mail),onPressed: (){

          },)),


          Align(alignment: Alignment.center,
            child: SizedBox(
                height: size.height / 2,
                child: Lottie.asset("assets/lottile/chat_animation.json",)),
          ),
          Align(alignment: Alignment.bottomCenter,
            child:
            _SignUpOrSignIn(size: size),
          ),

        ],
      ),
    );
  }
}

class _SignUpOrSignIn extends HookConsumerWidget {
  const _SignUpOrSignIn({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, ref) {
    final viewModel = ref.read(loginProvider.notifier);

    return Container(
      height: size.height / 3,
      margin: EdgeInsets.only(bottom: size.height / 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          //匿名ではじめる
          SignButton(size: size, isRegister: true, title: "新しくはじめる", onPressed: () {
            //
            viewModel.onSignInWithAnonymousUser(context);
          },),
          SizedBox(height: size.height / 20,),
          //既にお持ちの方
          SignButton(size: size, isRegister: false, title: "ログイン", onPressed: () {
            //
          },),
        ],
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  const SignButton({
    Key? key,
    required this.isRegister,
    required this.size,
    required this.title, required this.onPressed,

  }) : super(key: key);

  final Size size;
  final bool isRegister;
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
            color: isRegister ? Colors.white : Colors.black,
          ),
          child:
          Stack(
            children: [
              Align(alignment: Alignment.centerLeft,child:
              Icon(isRegister ? Icons.person_add : Icons.lock, color: isRegister ? Colors.blue : Colors.white,size: size.height / 27,)),
              Align(
                  alignment: Alignment.center,
                  child:
<<<<<<< HEAD
                  Text(title, style: TextStyle(color: isSignIn? Colors.black : Colors.white,
                      fontSize: size.height / 40,
                    fontFamily: 'MPlus'
                  ),)
=======
                  Text(title, style: GoogleFonts.mochiyPopOne(fontSize: size.height / 45, color: isRegister ? Color(0xFF4A4A4A): Colors.white))
                  // Text(title, style: TextStyle(color: isSignIn? Colors.black : Colors.white,
                  //     fontSize: size.height / 40,
                  //   fontFamily: ''
                  // ),)
>>>>>>> 54d112f (チャット機能を実装)
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
