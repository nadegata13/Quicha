import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../test_data.dart';
import '../../../viewModel/chat_viewmodel.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
    required this.topHeight,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final double topHeight;
  final Size size;
  final ChatViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    var nameTextStyle =  TextStyle(fontSize: size.height / 50, );
    var counterTextStyle = TextStyle(fontSize:  size.height / 70);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
            height: topHeight ,
            width: size.width / 3,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.only(right: size.width / 50),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 5,
                          child:
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(TestData.username, style: nameTextStyle,),
                          ),

                        ),
                        AnimatedFlipCounter(

                          duration: Duration(milliseconds: 500),
                          textStyle: counterTextStyle,
                          value: viewModel.victoryCount, // pass in a value like 2014
                        )
                      ],
                    )
                ),
                CircleAvatar(
                  radius: size.height / 50 ,
                ),
              ],
            )
        ),
        Container(width: size.width / 10,
            alignment: Alignment.center,
            child:
            Text("x")
        ),
        Container(
          height: topHeight ,
          width: size.width / 3,
          child:
          Row(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: SvgPicture.asset(TestData.profileImage),
                    radius: size.height / 50,
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(left: size.width / 50),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("user",
                          style: nameTextStyle),

                      Container(
                          child:
                          AnimatedFlipCounter(

                            duration: Duration(milliseconds: 500),
                            textStyle: counterTextStyle,
                            value: viewModel.victoryCount, // pass in a value like 2014
                          )
                      )
                    ],
                  )
              )
            ],

          ),
        )
      ],
    );
  }
}
