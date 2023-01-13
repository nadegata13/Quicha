import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:quicha/view/matching_screen/matching_screen.dart';
import 'package:quicha/viewModel/home_viewmodel/home_notifier.dart';


class MatchingButton extends HookConsumerWidget {
  const MatchingButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(homeProvider);
    final viewModel = ref.read(homeProvider.notifier);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        //タップ中の押し込まれたボタン
        Opacity(opacity: state.isClickedEntryButton? 1 : 0, child:
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

        Opacity(opacity: state.isClickedEntryButton ? 0 : 1, child:
        GestureDetector(
            onTapDown: (detail) {
              viewModel.entryTapDown();
            },
            onTapUp: (details) {
              viewModel.entryTapUp();
              Navigator.pushReplacement(context,
                   CupertinoPageRoute(
                // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) =>  MatchingScreen()

              ));
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
    );
  }
}
