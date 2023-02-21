import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_notifier.dart';
import 'package:spring_button/spring_button.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
        //キーボード出現時に上に上がる
        padding: EdgeInsets.only(bottom: bottomSpace),
        child: Column(
          children: [
            //選択された画像

            Container(
                width: size.width,
                padding: EdgeInsets.only(
                    left: size.width / 30,
                    right: size.width / 30,
                    top: size.height / 100,
                    bottom: size.height / 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.3)),
                  color: Colors.white,
                ),
                child: HookConsumer(builder: (context, ref, child) {
                  final controller = useState(TextEditingController());
                  final viewModel = ref.read(chatRoomProvider.notifier);
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    contentPadding: const EdgeInsets.all(10.0),
                                    content: Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              viewModel.requestNextQuiz();
                                              Navigator.pop(context);
                                            },
                                            child: Text("次の問題へ"),
                                          ),
                                          SizedBox(
                                            width: size.width / 50,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              viewModel.requestQuizAnswer();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "わからない……",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFf4f9f6),
                              border:
                                  Border.all(width: 0.2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.centerLeft,
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width / 50),
                          child: TextField(
                            controller: controller.value,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: size.width / 20,
                                  top: size.height / 100,
                                  bottom: size.height / 100),
                              border: InputBorder.none,
                              hintText: "何してる？",
                              hintStyle: TextStyle(
                                  color: Color(0xFFdee1e2),
                                  fontSize: size.height / 50),
                            ),
                          ),
                        ),
                      ),
                      SpringButton(
                        SpringButtonType.OnlyScale,
                        Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          ref
                              .read(chatRoomProvider.notifier)
                              .sendMessage(controller.value);

                          // ref.read(chatProvider).scrollDown();
                        },
                      )
                    ],
                  );
                }))
          ],
        ));
  }
}
