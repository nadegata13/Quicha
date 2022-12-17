import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/model/socket_client.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_notifier.dart';

class MatchingScreen extends HookConsumerWidget {
  const MatchingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref, ) {

    final state = ref.watch(matchingProvider);
    final viewModel = ref.read(matchingProvider.notifier);


    // useEffect((){
    //   //ロビーにエントリーする
    //   // viewModel.initEntryRoom();
    //
    //   return viewModel.close;
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text(state.matchingMessage),
        backgroundColor: CustomColor.appBarTheme,

      ),
      body:Container(
        child: Column(
          children: [
            Text(state.successJoinRoom),
            ElevatedButton(onPressed: (){
              viewModel.getMyRoom();
            }, child: Text("TEST")),

            ElevatedButton(onPressed: (){
              viewModel.test();
            }, child: Text("お試し")),

            Text("接続数: " + state.connectClientCount),
          ],
        ),
      ),
    );
  }
}
