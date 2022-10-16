import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicha/view/chat_screen/quiz_space.dart';
import 'package:quicha/view/chat_screen/widget/chat_area.dart';
import 'package:quicha/view/chat_screen/widget/chat_text_field.dart';
import 'package:quicha/viewModel/chat_viewmodel.dart';

import 'app_bar.dart';
import 'button_for_test.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
      ChangeNotifierProvider<ChatViewModel>(
          create: (context) => ChatViewModel(),
              child:
              GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child:
                  _Body(size: size)
              )

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

    final ChatViewModel viewModel = Provider.of<ChatViewModel>(context);
    var topHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
        appBar: AppBar(
          title:
          AppBarWidget(topHeight: topHeight, size: size, viewModel: viewModel),
        ),
        // backgroundColor: CustomColor.thinBlue,
        backgroundColor: Colors.white,


        body:
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child:
            Container(
                height: size.height - topHeight,
                child:
                Column(
                  children: [
                    //出題スペース
                    QuizArea(size: size, viewModel: viewModel),


                    //TODO: 後で消す
                    //テスト用ボタン
                    ButtonsForTest(size: size, viewModel: viewModel),

                    //
                    ChatArea(size: size, viewModel: viewModel),
                    //入力欄
                    ChatTextField(size: size)


                  ],
                )
            )
        )
    );
  }
}







