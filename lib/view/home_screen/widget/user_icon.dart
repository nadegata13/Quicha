import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:spring_button/spring_button.dart';

import '../../../ui/custom_style.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SpringButton(
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
          Container(
            height: size.height / 10,
            //ユーザーアイコン
            child:SvgPicture.asset("assets/images/character_icon/human.svg"),
          )
          //タップ時にアイコン選択画面が出てくる
        ],
      ),
      onTap: () {

      },
      scaleCoefficient: 0.9,
    );
  }
}
