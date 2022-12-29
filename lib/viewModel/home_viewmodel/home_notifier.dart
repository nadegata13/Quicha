import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/socket_client.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
    ((ref) {
      ref.onDispose(() {
        SocketClient.instance.socket!.emit('leaveRoom');
        SocketClient.instance.socket!.clearListeners();
      });
      return HomeNotifier();
    })
);


class HomeNotifier extends StateNotifier<HomeState> {

  late Socket _socketClient;

  HomeNotifier() : super(const HomeState()){
    _socketClient = SocketClient.instance.socket!;

  }


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
