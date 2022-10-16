import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../viewModel/home_viewmodel.dart';

class MatchingButton extends ConsumerWidget {
  const MatchingButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final watchProvider = ref.watch(homePorovider);
    final readProvider = ref.watch(homePorovider);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        //タップ中の押し込まれたボタン
        Opacity(opacity: watchProvider.isClicked? 1 : 0, child:
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

        Opacity(opacity: watchProvider.isClicked ? 0 : 1, child:
        GestureDetector(
            onTapDown: (detail) {
              readProvider.entryTapDown();
            },
            onTapUp: (details) {
              readProvider.entryTapUp();
            },
            onTapCancel: () => readProvider.entryTapCancel(),
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
