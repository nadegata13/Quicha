import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/socket_methods.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/socket_client.dart';

final matchingProvider = StateNotifierProvider.autoDispose<MatchingNotifier, MatchingState>(
    ((ref) {
      ref.onDispose(() {
        SocketClient.instance.socket!.emit('leaveRoom');
        SocketClient.instance.socket!.clearListeners();
      });
      return MatchingNotifier();
    })
);


class MatchingNotifier extends StateNotifier<MatchingState> {

    late Socket _socketClient;

  MatchingNotifier() : super(const MatchingState()){
    _socketClient = SocketClient.instance.socket!;

    initEntryRoom();
  }





  void entryRoby() {
    _socketClient.emit('entryRoby', {
      'userId' : "12345",
    });
  }
  void getMyRoom() {
    _socketClient.emit('getMyRoom');
  }

  void test(){
    //TEST
    _socketClient.emit('test');
  }
    void initEntryRoom()  {
      entryRoby();


      _socketClient.on('successJoinRoom', (data) {
        state = state.copyWith(successJoinRoom: "${data}");
        print(data);
      });

      _socketClient.on('matchingUser', (data){
        state = state.copyWith(matchingMessage: "マッチングしました！");
        print("マッチングしました！");
      });

      _socketClient.on('getClientCount', (data){
        state = state.copyWith(connectClientCount: data + "人");
        print(data);
      });

  }
  void close(){
    _socketClient.emit('leaveRoom');
    _socketClient.clearListeners();
  }




}
