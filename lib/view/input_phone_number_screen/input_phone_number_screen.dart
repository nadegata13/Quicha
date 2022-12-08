import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/login_viewmodel/login_notifier.dart';


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

class _PhoneTextField extends HookConsumerWidget {
   _PhoneTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, ref ) {
    final textEditingController = useState(TextEditingController());
    final isEmpty = useState(false);
    return Column(
      children: [

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width / 20),
          child: TextField(
            onChanged: (text){
              isEmpty.value = text.isEmpty;
            },
            controller: textEditingController.value,
              textAlign: TextAlign.center,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: size.height / 40,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric( vertical: size.height / 300),
                  prefix: Container(
                    height: size.height / 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(Icons.call, color: Colors.blueAccent,),
                  ),
                  suffix: Container(
                    child: IconButton(
                      onPressed: (){
                        textEditingController.value.clear();
                        print(textEditingController.value.text);

                        },
                        icon: Icon(Icons.clear, color: Colors.grey, size: size.height / 50,)),
                  ),
                  fillColor: Colors.white,
                  hintText: "電話番号",
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, ),
                      borderRadius: BorderRadius.circular(25.0))
              )),
        ),
        IconButton(onPressed: isEmpty.value? null : (){
          ref.read(loginProvider.notifier).verifyPhone(textEditingController.value.text);
        },
          icon: Icon(Icons.east,color: isEmpty.value? Colors.grey : Colors.blueAccent  , ), iconSize: size.height / 15,)
      ],
    );
  }
}