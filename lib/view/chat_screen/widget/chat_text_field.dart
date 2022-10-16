import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';

import '../../../viewModel/chat_viewmodel.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    var bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final ChatViewModel viewModel = Provider.of<ChatViewModel>(context);

    return Padding(
      //キーボード出現時に上に上がる
        padding: EdgeInsets.only(bottom: bottomSpace),
        child:
        Column(
          children: [
            //選択された画像

            Container(
                width: size.width,
                padding: EdgeInsets.only(left: size.width / 30, right:  size.width / 30, top: size.height / 100, bottom:  size.height / 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
                  color: Colors.white,
                ),
                child:

                Row(
                  children: [
                    Icon(Icons.add),
                    Expanded(child:
                    Container(
                      decoration: BoxDecoration(color: Color(0xFFf4f9f6),
                          border: Border.all(width: 0.2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: size.width / 50),
                      child:
                      TextField(
                        controller: viewModel.txtController,
                        minLines: 1,
                        maxLines: 3,

                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: size.width / 20, top: size.height / 100, bottom: size.height / 100),
                          border: InputBorder.none,
                          hintText: "何してる？" ,
                          hintStyle: TextStyle(color: Color(0xFFdee1e2), fontSize: size.height / 50),
                        ),

                      ),
                    ),
                    ),
                    SpringButton(SpringButtonType.OnlyScale,
                      Icon(Icons.send,color: Colors.blue,),
                      onTap: () {
                        viewModel.sendMessage();
                      },
                    )

                  ],
                )
            ),

          ],
        )
    );
  }
}
