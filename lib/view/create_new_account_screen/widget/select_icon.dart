import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/chat_viewmodel.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../../ui/character_icons.dart';
import '../../../viewModel/new_account_viewmodel.dart';

class SelectIcon extends StatelessWidget {
  const SelectIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // アイコンを選択
        Padding(padding: EdgeInsets.only(top: size.height / 50 , bottom: size.height / 50),
          child:
          Text("アイコンをえらぶ", style: CustomStyle.newAccountTextStyle(size),),
        ),
        Container(
          height: size.height / 7,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: size.width / 20),
          child:
            DynamicHorizontalDemo(size: size,)
        )

      ],
    );
  }
}
class DynamicHorizontalDemo extends ConsumerStatefulWidget {
  DynamicHorizontalDemo({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  _DynamicHorizontalDemoState createState() => _DynamicHorizontalDemoState();
}

class _DynamicHorizontalDemoState extends ConsumerState<DynamicHorizontalDemo> {
  List<int> data = [];

  @override
  void initState() {
    super.initState();
    ref.read(chatProvider);

  }

  void _onItemFocus(int index) {
    print(index);
    ref.read(newAccountProvider).setIcon(icon: CharacterIcons.getIcon(index));
  }



  Widget _buildListItem(BuildContext context, int index,) {

    final Size size = MediaQuery.of(context).size;

    //horizontal
    return Container(
      width: size.width / 4,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(size.height / 200),
      child:

      Stack(
        alignment: Alignment.center,
        children: [

      AnimatedOpacity(opacity: ref.watch(newAccountProvider).selectedIcon == CharacterIcons.getIcon(index) ?
      1 : 0,
      duration: Duration(milliseconds: 500),
        child:
        Container(
          height: 50,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0,50),
                  blurRadius: 7
              ),
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(10,50),
                  blurRadius: 9
              ),
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-10,50),
                  blurRadius: 9
              ),
            ],
          ),
        ),
      ),
          AnimatedOpacity(opacity: ref.watch(newAccountProvider).selectedIcon == CharacterIcons.getIcon(index) ?
              1 : 0,
          duration: Duration(milliseconds: 500),
          child:
      Container(height: size.height / 12.5, width: size.height / 12.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
          // boxShadow:[
          //
          //   BoxShadow(
          //     blurStyle: BlurStyle.normal,
          //     color: Colors.grey, //色
          //     spreadRadius: 0,
          //     blurRadius:15,
          //     offset: Offset(0, 10),
          //   ),
          // ]
      ),
        child:
        CustomPaint(foregroundPainter:
        _CircleBlurPainter(circleWidth: 4, blurSigma: 1),
        ),
      )
          ),
          Container(
            height: size.height / 12.5,
            width: size.height / 12.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.3, color: Colors.grey),
            ),
            child: SvgPicture.asset(CharacterIcons.getIcon(index).getPath),
          ),
        ],
      )
    );
  }

  ///Override default dynamicItemSize calculation

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return
    ScrollSnapList(
    onItemFocus: _onItemFocus,
    focusOnItemTap: true,
    itemSize: size.width / 4,
    itemBuilder: _buildListItem,
    itemCount: 6,
    dynamicItemSize: true,
    scrollDirection: Axis.horizontal,
    listController: ScrollController(),

    );
  }
}



class _CircleBlurPainter extends CustomPainter {

  _CircleBlurPainter({required this.circleWidth, required this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
