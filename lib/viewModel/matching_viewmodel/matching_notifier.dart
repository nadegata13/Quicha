import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/socket_methods.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_state.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:intl/intl.dart';

import '../../model/DateFormatter.dart';
import '../../model/socket_client.dart';

final matchingProvider = StateNotifierProvider.autoDispose<MatchingNotifier, MatchingState>(
    ((ref) {
      ref.onDispose(() {
        SocketClient.instance.socket!.emit('leaveRoom');
        SocketClient.instance.socket!.clearListeners();
        ref.notifier._timer.cancel();
      });
      return MatchingNotifier();
    })
);


class MatchingNotifier extends StateNotifier<MatchingState> {

    late Socket _socketClient;
    late Timer _timer;

  MatchingNotifier() : super(const MatchingState()){
    _socketClient = SocketClient.instance.socket!;

    int periodCount = 1;



    //マッチング中のテキスト処理
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print("timer");
      print(periodCount);
      if(periodCount > 5) {
        periodCount = 1;
      }
      String matchingMessage = " " * periodCount + "マッチング中" + (".") * periodCount;
      state = state.copyWith(matchingMessage: matchingMessage);
      periodCount++;
    });

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


    bool isVisibleBus = !state.isVisibleBus;
    print(isVisibleBus);

    bool isAnimation = !state.isAnimation;
    state = state.copyWith(isVisibleBus: isVisibleBus, isAnimation: isAnimation );
  }
    void initEntryRoom()  {
      entryRoby();


      _socketClient.on('successJoinRoom', (data) {
        state = state.copyWith(successJoinRoom: "${data}");
        print(data);
      });

      _socketClient.on('matchingUser', (data){
        _timer.cancel();

        state = state.copyWith(matchingMessage:"マッチングしました!");

        if(FirebaseAuth.instance == null) { throw Error(); }

        //ユーザーIDを相手に渡す
        final userID = FirebaseAuth.instance.currentUser!.uid;
        _socketClient.emit('sendUserProfile', userID);

      });

      _socketClient.on("receiveUserProfile", (data){
        final int opponentIcon = data["icon"];
        final String opponentNickname = data["nickname"];

        state = state.copyWith(opponentNickname: opponentNickname, opponentIcon: opponentIcon,
        isAnimation: true, isVisibleBus: false);
      });

      _socketClient.on('getClientCount', (data){
        state = state.copyWith(connectClientCount: data + "人");
        print(data);
      });
      _socketClient.on('testDate', (data) {
        print(data);
        print(data.runtimeType);

        print(DateFormatter.dateFormatter(data));
      });
    }




  void close(){
    _socketClient.emit('leaveRoom');
    _socketClient.clearListeners();
  }




}
