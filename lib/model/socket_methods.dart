import 'package:flutter/animation.dart';
import 'package:quicha/model/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  // void createRoom(String nickname) {
  //   if(nickname.isNotEmpty) {
  //     _socketClient.emit('createRoom', {
  //       'nickname' : nickname,
  //     });
  //
  //     _socketClient.on('message', (data) => print(data));
  //
  //     _socketClient.emit('entryRoby', {
  //       'userID' : nickname,
  //     });
  //   }
  // }

  void entryRoby() {
    _socketClient.emit('entryRoby', {
      'userId' : "12345",
    });
  }
  void getMyRoom(){
    _socketClient.emit('getMyRoom');
  }

  void successJoinRoom()  {
    _socketClient.on('successJoinRoom', (data) => print(data));
  }
}