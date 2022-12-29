import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/view/common_widget.dart';
import 'package:quicha/viewModel/home_viewmodel/home_notifier.dart';
import 'package:spring_button/spring_button.dart';

import '../../../ui/custom_style.dart';

class UserIcon extends HookConsumerWidget {
  const UserIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;


  @override
  Widget build(BuildContext context, ref) {

    final state = ref.watch(homeProvider);

    return
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
      ),
      onPressed: () {
        ref.read(homeProvider.notifier).test();
      },
      child:
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height / 8.8,
            width: size.height / 8.8,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColor.userIconFrame, width: 10),
                shape: BoxShape.circle

            ),
          ),

          CircleIcon(size: size.height / 10, imagePath: state.iconPath),
          // Container(
          //   height: size.height / 10,
          //   //ユーザーアイコン
          //   child:SvgPicture.asset("assets/images/character_icon/human.svg"),
          // )
          //タップ時にアイコン選択画面が出てくる
        ],
      ),
    );
      SpringButton(
      SpringButtonType.OnlyScale,

      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: size.height / 8.8,
            width: size.height / 8.8,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColor.userIconFrame, width: 10),
                shape: BoxShape.circle

            ),
          ),

          CircleIcon(size: size.height / 10, imagePath: state.iconPath),
          // Container(
          //   height: size.height / 10,
          //   //ユーザーアイコン
          //   child:SvgPicture.asset("assets/images/character_icon/human.svg"),
          // )
          //タップ時にアイコン選択画面が出てくる
        ],
      ),
      onTap: () {
        ref.read(homeProvider.notifier).test();

      },
      scaleCoefficient: 0.9,
    );
  }
}
