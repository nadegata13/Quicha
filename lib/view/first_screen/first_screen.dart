import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FirstScreen extends StatelessWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          height: size.height,
          child:
          FittedBox(
              fit: BoxFit.fitHeight,
              child: SvgPicture.asset('assets/images/background/background.svg',
              )
          )
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width / 10),
          width: size.width,
          child: SvgPicture.asset('assets/images/logo/quichaLogo.svg',
          ),
        )

      ],
    );
  }
}

