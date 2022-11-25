import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';


class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.backgroundYellow,

      body:
      Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height / 30),
              height: size.height / 3 ,
              child:
                Lottie.network("https://assets2.lottiefiles.com/packages/lf20_jcikwtux.json",),
            ),

            Text("電話番号", style: TextStyle(fontSize: size.height / 50),),

              SizedBox(height: size.height / 30,),

            Container(
              decoration: BoxDecoration(color: Color(0xFFf4f9f6),
                  border: Border.all(width: 0.2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: size.width / 50),
              child:
              TextField(
                controller: TextEditingController(),
                maxLines: 1,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: size.width / 10, top: size.height / 100, bottom: size.height / 100),
                  border: InputBorder.none,
                  hintText: "入力してください" ,
                  hintStyle: TextStyle(color: Color(0xFFdee1e2), fontSize: size.height / 50),
                ),

              ),
            ),


          ],
        ),
      ),
    );
  }
}