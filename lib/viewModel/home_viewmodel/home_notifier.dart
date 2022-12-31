import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/socket_client.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
    ((ref) {
      ref.onDispose(() {
        SocketClient.instance.socket!.clearListeners();
      });
      return HomeNotifier();
    })
);


class HomeNotifier extends StateNotifier<HomeState> {

  late Socket _socketClient;

  HomeNotifier() : super(const HomeState()){
    _socketClient = SocketClient.instance.socket!;

    _receiveEvent();

    //アカウント情報をサーバーに要求
    _queryAccountInfo();

  }


  void test(){
    state = state.copyWith(iconPath: "assets/images/character_icon/penguin.png");
  }

  void _receiveEvent() {

    //アカウント情報を受け取る;
    _socketClient.on("passAccountInfo", (data) {

      int _icon = data['icon'];

      String nickname = data['nickname'];

      String iconPath = CharacterIcons.getIcon(_icon).getPath;


      state = state.copyWith(iconPath: iconPath, nickname: nickname);
    });
  }

  //アカウント情報をサーバーに要求
  void _queryAccountInfo() {

    final currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser == null){ return; }

    _socketClient.emit("queryAccountInfo", currentUser!.uid );
  }

  /**
   * マッチングルームへのボタンの挙動
   */

  void entryTapDown() {
    state = state.copyWith(isClickedEntryButton: true);
  }
  void entryTapUp() {
    state = state.copyWith(isClickedEntryButton: false);
  }
  void entryTapCancel() {
    state = state.copyWith(isClickedEntryButton: false);
  }
}
