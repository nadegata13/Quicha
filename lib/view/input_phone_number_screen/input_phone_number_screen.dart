import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';


class InputPhoneNumberScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColor.backgroundYellow,

      body:
      Container(
        padding: EdgeInsets.only(top: size.height / 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:
            Container(
                padding: EdgeInsets.only(left: size.width / 10, top: size.height / 50),
                child: InkResponse(child: Icon(Icons.arrow_back_ios,color: Colors.black,),
                  onTap: () {
                  //前の画面に戻る
                    Navigator.pop(context);
                  },
                )),),
            Container(
              height: size.height / 3 ,
              child:
                Lottie.network("https://assets2.lottiefiles.com/packages/lf20_jcikwtux.json",),
            ),

            Text("ログイン／新規登録", style: TextStyle(fontSize: size.height / 50),),

              SizedBox(height: size.height / 30,),

            _PhoneTextField(size: size)


          ],
        ),
      ),
    );
  }
}

class _PhoneTextField extends HookWidget {
   _PhoneTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useState(TextEditingController());
    var isTextFill = useState(textEditingController.value.text.length > 0);
    return Column(
      children: [

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width / 20),
          child: TextField(
            controller: textEditingController.value,
              textAlign: TextAlign.center,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: size.height / 40,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric( vertical: size.height / 70),
                  prefixIcon: Icon(Icons.call),
                  suffixIcon: Icon(Icons.clear, color: Colors.grey, size: size.height / 50,),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "携帯番号(11ケタ)",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, ),
                      borderRadius: BorderRadius.circular(25.0))
              )),
        ),
        IconButton(onPressed: (){print(isTextFill);}, icon: Icon(Icons.east,color: isTextFill.value? Colors.blueAccent : Colors.grey, ), iconSize: size.height / 15,)
      ],
    );
  }
}