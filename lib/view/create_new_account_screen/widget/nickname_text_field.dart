import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/ui/custom_style.dart';

import '../../../viewModel/new_account_viewmodel.dart';

class NickNameTextField extends StatelessWidget {
  const NickNameTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding:  EdgeInsets.symmetric(vertical: size.height / 15),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            Text("ニックネームを入力", style: CustomStyle.newAccountTextStyle(size),),

            SizedBox(height: size.height / 20,),

            Container(
              width:  size.width - 100,
              height: size.height / 15,
              padding: EdgeInsets.symmetric(horizontal: size.width / 10, vertical: size.height / 100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(30),
                  // color: CustomColor.appBarTheme.withOpacity(0.7)
              ),
              child:
              _NickName(),
            )
          ],
        ),
      ),
    );
  }
}

class _NickName extends ConsumerWidget {
  const _NickName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 10,
      controller: ref.watch(newAccountProvider).nicknameController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hoverColor: Colors.red,
        hintText: "ニックネーム",
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
