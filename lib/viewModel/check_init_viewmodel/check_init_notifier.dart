import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../repository/socket_client.dart';

final checkInitProvider = ChangeNotifierProvider.autoDispose((ref) {
  ref.onDispose(() {
    SocketClient.instance.socket!.clearListeners();
  });
  return CheckInitNotifier();
});

class CheckInitNotifier extends ChangeNotifier {
  late Socket _socketClient;
  int routeNumber = 0;

  CheckInitNotifier() {
    _socketClient = SocketClient.instance.socket!;

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (_firebaseAuth.currentUser == null) {
      Future.delayed(Duration(seconds: 1), () {
        routeNumber = 200;
        notifyListeners();
      });
      return;
    }
    _socketClient.emit("checkRegisteredUser", _firebaseAuth.currentUser!.uid);
    _receiveEvent();

    print("checkInitScreen");
  }

  void _receiveEvent() {
    _socketClient.on("goToScreen", (data) {
      print(data);
      print("init!!");
      if (data == 200) {
        routeNumber = 200;
      } else {
        routeNumber = 100;
      }
      notifyListeners();
    });
  }
}
