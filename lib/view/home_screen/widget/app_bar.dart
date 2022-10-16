import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spring_button/spring_button.dart';

import '../../../ui/custom_style.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget{
  const HomeAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: CustomColor.appBarTheme,
      elevation: 2,
      centerTitle: true,
      //メール
      leading:
      Container(
          padding: EdgeInsets.only(left: size.width / 20),
          child:
          SpringButton(
            SpringButtonType.OnlyScale,
            Icon(Icons.mail,size: size.height / 25,),
            onTap: (){
            },
          )
      ),

      title:
      Container(
        height: size.height / 25,
        child: SvgPicture.asset('assets/images/logo/quichaLogo.svg',
        ),
      ),
      actions: [
        //ベル
        SpringButton(
          SpringButtonType.OnlyScale,
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications_outlined,
                size: size.height / 25,
              ),
              Positioned(right: 5, top: 18,
                  child:
                  //TODO:
                  //通知を受け取ったら表示する
                  Opacity(
                      opacity: 1,
                      child:
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red
                        ),
                      )
                  )
              )
            ],
          ),
          onTap: () {},
        ),
        SpringButton(
          SpringButtonType.OnlyScale,
          Icon(
            Icons.settings_rounded,
            size: size.height / 25,
          ),
          onTap: () {

          },
        ),

        SizedBox(width: size.width / 30,)

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(kToolbarHeight);
}
