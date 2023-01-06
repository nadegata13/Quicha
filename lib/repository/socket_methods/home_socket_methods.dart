import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/home_data.dart';
import 'package:quicha/repository/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';




class HomeSocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  final socketResponse = StreamController<dynamic>();

  HomeSocketMethods(){

  }

  //アカウント情報を要求する
  void queryAccountInfo() {

    final currentUser = FirebaseAuth.instance.currentUser;
    print("queryAccountInfo");

    if(currentUser == null){ return; }

    _socketClient.emit("queryAccountInfo", currentUser!.uid );
  }

  //アカウント情報を受け取る;
  void onPassAccountInfo() {

    _socketClient.on("passAccountInfo", (data) {
      print("passAccountInfo");

      int icon = data['icon'];
      int lifeCount = data['lifeCount'];
      String lifeUpdate = data['lifeUpdate'];

      String nickname = data['nickname'];


      socketResponse.sink.add(
        PassAccountInfoData(icon: icon, nickname: nickname, lifeUpdateStr: lifeUpdate, lifeCount: lifeCount)
      );
    });

  }

  void emitTest(){
    print("emitTest");
    _socketClient.emit("testHome");
  }
  void onTest(){
    print("onTest");
    _socketClient.on("testEvent", (data) {
      print("test成功");
    });
  }

  //ライフのアップデートが成功したら。
  void onSuccessUpdateLifeCount() {

    _socketClient.on("successUpdateLife", (data){

      print("successUpdateLifeCount" );

      int lifeCount = data["lifeCount"];
      String lifeUpdateStr = data["lifeUpdate"];


      socketResponse.sink.add(
        SuccessUpdateLifeData(lifeCount: lifeCount, lifeUpdateStr: lifeUpdateStr)
      );

    });
  }

  //戻る時の挙動
  void close(){
    _socketClient.clearListeners();
  }

}
