import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quicha/test_data.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/home_viewmodel.dart';
import 'package:spring_button/spring_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
      ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
          child:
          _Body(size: size)
      );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);

    return
      Scaffold(
          backgroundColor: CustomColor.backgroundYellow,

          appBar: AppBar(backgroundColor: CustomColor.appBarTheme,
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
                    log("aaaa");
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
          ),

          body:
          Center(
              child:
              Column(
                children: [
                  Container(
                      width: size.width / 2,
                      child:
                      Column(
                        children: [

                          //ライフ復活時間
                          Padding(padding: EdgeInsets.symmetric(vertical: size.height / 50),
                            child:
                            Opacity(opacity: 1,
                              child:
                              Align(alignment: Alignment(0.9,0),
                                child: Text(TestData.currentTime),
                              ),
                            ),
                          ),



                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //ライフ（引数の数は緑色のハートの数)
                            children: _restLifes(TestData.fillLifeCount),
                          )
                        ],
                      )
                  ),

                  SizedBox(height: size.height / 50,),


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
                  ),

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
                        Container(
                          width: size.width / 3,
                          height: size.height / 12,
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: size.height / 100),
                          child:
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(TestData.username, style: TextStyle(fontSize: size.height / 25,
                                fontWeight: FontWeight.w900),),
                          ),

                        ),

                      ]
                  ),
                  Container(
                    width: size.width / 2,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 0.5,))
                    ),
                  ),

                  SizedBox(height: size.height / 25,),

                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      //タップ中の押し込まれたボタン
                      Opacity(opacity: viewModel.isClicked ? 1 : 0, child:
                      InkResponse(
                          onTap: null,
                          child:
                          Container(
                            width: size.height / 4.5,
                            child:

                            Image.asset("assets/images/system/clickedEntryButton.png" ),
                          )
                      ),
                      ),

                      Opacity(opacity: viewModel.isClicked ? 0 : 1, child:
                      GestureDetector(
                          onTapDown: (detail) {
                            viewModel.entryTapDown();
                          },
                          onTapUp: (details) {
                            viewModel.entryTapUp();
                          },
                          onTapCancel: () => viewModel.entryTapCancel(),
                          child:
                          Container(
                            width: size.height / 4.5,
                            child:

                            Image.asset("assets/images/system/entryButton.png" ),
                          )

                      )
                      ),
                    ],
                  ),

                  SizedBox(height: size.height / 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("クイズ作成"),
                          SpringButton(SpringButtonType.OnlyScale,
                              Container(
                                  height: size.height / 10,
                                  child:
                                  SvgPicture.asset("assets/images/system/makeQuiz.svg")
                              ),
                              onTap: () {},
                              ),
                        ],
                      ),
                      SizedBox(width: size.width / 10,),
                      Column(
                        children: [
                          Text("SHOP"),
                          SpringButton(SpringButtonType.OnlyScale,
                              Container(
                                  height: size.height / 10,
                                  child:
                                  SvgPicture.asset("assets/images/system/shop.svg")
                              ),
                            onTap: (){},
                          ),
                        ],
                      ),
                    ],
                  ),


                ],
              )
          )
      );
  }
  List<Widget> _restLifes(int lifeCount) {

    final fillCount = 5;
    List<Widget> lifes = [];

    //fillLife
    for(int i = 0; i < lifeCount; i++){
      lifes.add(_Lifes(size: size, isFill: true));
    }
    //blankLife
    for(int i = 0; i < fillCount - lifeCount; i++){
      lifes.add(_Lifes(size: size, isFill: false));
    }




    return lifes;
  }
}

class _Lifes extends StatelessWidget {
  const _Lifes({
    Key? key,
    required this.size,
    required this.isFill,
  }) : super(key: key);

  final Size size;
  final bool isFill;

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
          flex: 1,
          child:
          Container(
            height: size.height / 30,
            child:
            Image.asset(isFill ? "assets/images/system/lifeFill.png" : "assets/images/system/lifeBlank.png"),
          )
      );
  }
}


