import 'package:flutter/material.dart';


//円形アイコン
class CircleIcon extends StatelessWidget {
  final double size;
  final String imagePath;

  CircleIcon({required this.size,
    required this.imagePath,});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.3, color: Colors.grey),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imagePath)
            )
        ),
      );
  }
}


class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key? key, required this.dialog}) : super(key: key);

  final Widget dialog;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _initScaleAnimation();
  }

  _initScaleAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear)
    )..addListener(() {
      setState(() => scale = animation.value);
    });

    controller.forward();
  }

  var scale = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.topCenter,
          child:
          Transform.scale(
            scale: scale,
            child: widget.dialog,
          ),
        )
      ],
    );
  }
}
