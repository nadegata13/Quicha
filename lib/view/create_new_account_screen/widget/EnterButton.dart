import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/common_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
    return Opacity(
        opacity: 0.9,
        child: SpringButton(
          SpringButtonType.OnlyScale,
          Container(
              height: size.height / 10,
              child: Lottie.asset("assets/lottile/startBtn.json",
                  fit: BoxFit.fill)),
          onTap: () {
            if (ref.watch(newAccountProvider).nicknameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("ニックネームを入力してください"),
                ),
              );
              return;
            }
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    backgroundColor: CustomColor.thinBlue,
                    contentPadding: EdgeInsets.only(top: 10.0),
                    content: _DialogContent(),
                  );
                });
            print(ref.watch(newAccountProvider).nicknameController.text);
          },
        ));
  }
}

class _DialogContent extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final Size size = MediaQuery.of(context).size;

    final watchProvider = ref.watch(newAccountProvider);

    return Container(
      width: size.width - 100,
      padding: EdgeInsets.symmetric(
          vertical: size.height / 50, horizontal: size.width / 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //戻るボタン
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                iconSize: size.height / 20,
                onPressed: watchProvider.isLoading
                    ? null
                    : () {
                        Navigator.of(context).pop();
                      },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blueAccent,
                )),
          ),

          Container(
            height: size.height / 4,
            width: size.height / 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: EdgeInsets.all(size.height / 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIcon(
                    size: size.height / 10,
                    iconNum: watchProvider.selectedIcon.index),
                Container(
                    padding: EdgeInsets.only(top: size.height / 100),
                    child: Text(
                      watchProvider.nicknameController.text,
                      style: TextStyle(
                          fontSize: size.height / 50,
                          fontWeight: FontWeight.w700),
                    ))
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
                Text(
                  "このアバターで設定しますか？",
                  style: TextStyle(
                      fontSize: size.height / 70, color: Colors.black54),
                ),
                SizedBox(
                  height: size.height / 100,
                ),
                Text(
                  "※登録後も変更ができます",
                  style: TextStyle(
                      fontSize: size.height / 80, color: Colors.black54),
                ),
                SizedBox(
                  height: size.height / 10,
                ),
                Container(
                    child: RoundedLoadingButton(
                  width: size.width / 2,
                  height: size.height / 17,
                  child: Text(
                    "決定",
                    style: GoogleFonts.mochiyPopOne(fontSize: size.height / 50),
                  ),
                  controller: watchProvider.btnController,
                  successColor: Colors.green,
                  onPressed: () {
                    ref.read(newAccountProvider).createNewAccount(context);
                  },
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Widget buildCustomButton(ButtonState state, VoidCallback onPressed, double height, double width) {
  //   var progressTextButton = ProgressButton(
  //     // height: height,
  //     // minWidth: width,
  //
  //     stateWidgets: {
  //       ButtonState.idle: Text(
  //         "はじめる",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  //       ),
  //       ButtonState.loading: Text(
  //         "",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  //       ),
  //       ButtonState.fail: Text(
  //         "Fail",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  //       ),
  //       ButtonState.success: Text(
  //         "ようこそ！",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
  //       )
  //     },
  //     stateColors: {
  //       ButtonState.idle: Colors.green.shade400,
  //       ButtonState.loading: Colors.blue.shade300,
  //       ButtonState.fail: Colors.red.shade300,
  //       ButtonState.success: Colors.green.shade400,
  //     },
  //     onPressed: onPressed,
  //     padding: EdgeInsets.all(8.0),
  //     state: state,
  //   );
  //   return progressTextButton;
  // }
}
