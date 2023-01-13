import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/matching_data.dart';
import 'package:quicha/repository/socket_client.dart';

final matchingSocketProvider = Provider(MatchingSocketMethods.new);

class MatchingSocketMethods {
  final ProviderRef ref;
  final _socketClient = SocketClient.instance.socket!;
  final socketResponse = StreamController<MatchingData>();

  MatchingSocketMethods(this.ref){

  }


  //ロビーに入室
  void entryRoby() {
    _socketClient.emit('entryRoby', {
      'userId' : "12345",
    });
  }

  //接続クライアント数を取得
  void onGetClientCount() {
    _socketClient.on('getClientCount', (data){

      socketResponse.sink.add(
        ClientCountData(connectClientCount: data + "人" )
      );
    });
  }

  //マッチングした後
  void onMatchedUser() {

    _socketClient.on('matchingUser', (data){

      // _timer.cancel();

      socketResponse.sink.add(
        MatchedMessageData(matchingMessage: "マッチングしました!")
      );
      if(FirebaseAuth.instance == null) { throw Error(); }

      //ユーザーIDを相手に渡す
      final userID = FirebaseAuth.instance.currentUser!.uid;

      _socketClient.emit('sendUserProfile', userID);

    });
  }
  //ユーザープロフィールを受け取った時
  void onReceiveUserProfile() {

    _socketClient.on("receiveUserProfile", (data){
      final String opponentUserID = data["userID"];
      final int opponentIcon = data["icon"];
      final String opponentNickname = data["nickname"];
      socketResponse.sink.add(
        ReceiveUserData(opponentUserID: opponentUserID, opponentIcon: opponentIcon, opponentNickname: opponentNickname,
        isAnimation: true, isVisibleBus: false)
      );
    });

  }


  //戻る時の挙動
  void close(){
    _socketClient.emit('leaveRoom');
    _socketClient.clearListeners();
  }

}