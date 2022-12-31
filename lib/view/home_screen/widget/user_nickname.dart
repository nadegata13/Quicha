import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/viewModel/home_viewmodel/home_notifier.dart';
import 'package:spring_button/spring_button.dart';

import '../../../test_data.dart';

class UserNickName extends HookConsumerWidget {
  const UserNickName({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, ref) {

    final state = ref.watch(homeProvider);

    return Column(
      children: [
        Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(width: size.width / 2,),
              //ニックネーム変更ボタン
              Positioned(right: 0,
                  bottom: 1,
                  child:
                  SpringButton(
                    SpringButtonType.OnlyScale,
                    Icon(
                      Icons.edit,
                    ),
                    onTap: () {

                    },
                  )
              ),
              //ニックネーム(可変長）
              Container(
                width: size.width / 3,
                height: size.height / 12,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: size.height / 100),
                child:
                FittedBox(
                  fit: BoxFit.scaleDown,
                  //ニックネーム
                  child: Text(state.nickname, style: TextStyle(fontSize: size.height / 25,
                      fontWeight: FontWeight.w900),),
                ),

              ),

            ]
        ),
        //線
        Container(
          width: size.width / 2,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 0.5,))
          ),
        ),
      ],
    );
  }
}
