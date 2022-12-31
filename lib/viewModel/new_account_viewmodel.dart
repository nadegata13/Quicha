
import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';


import '../model/socket_client.dart';


final newAccountProvider = ChangeNotifierProvider.autoDispose((ref) {
  ref.onDispose(() {
    SocketClient.instance.socket!.clearListeners();
  });
  return NewAcountNotifier();
});

class NewAcountNotifier extends ChangeNotifier{

  late Socket _socketClient;
  late BuildContext? _context;

  NewAcountNotifier() {
    _socketClient = SocketClient.instance.socket!;

    _receiveEvent();
  }

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final isFillNickname = false;
  var isLoading = false;
  // var buttonState = ButtonState.idle;

  TextEditingController nicknameController = TextEditingController();
  CharacterIcons selectedIcon = CharacterIcons.default_azarashi;

  void _receiveEvent() {
    /**
     *新規アカウント保存のレスポンス
     */
    _socketClient.on("resultRegisterAccount", (data){

      if(_context == null) { return;}

      int RESULT_EXITED = 300;
      int RESULT_ERROR = 200;
      int RESULT_SUCCESS = 100;

      if(data == RESULT_EXITED) {

        this.isLoading = false;
        btnController.error();

        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
            content: Text("アカウントが重複しています。"),
          ), );

      }else if(data == RESULT_ERROR) {

        this.isLoading = false;
        btnController.error();
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
            content: Text("なんらかの理由でユーザーが登録できませんでした。", ),
          ), );

      } else if(data == RESULT_SUCCESS) {
        btnController.success();

        Future.delayed(Duration(seconds: 1), () {

          //ホーム画面に遷移
          Navigator.push(_context!, MaterialPageRoute(
            // （2） 実際に表示するページ(ウィジェット)を指定する
              builder: (context) => HomeScreen()
          ));
        });
      }
      notifyListeners();
    });
  }

  void setIcon({required icon}) {
    this.selectedIcon = icon;
    notifyListeners();
  }

  void createNewAccount(BuildContext context) async {

    //コンテキストをフィールドに代入

    _context = context;

    //ローディング中は戻れない。
    this.isLoading = true;

    if(FirebaseAuth.instance.currentUser == null){
      return;
    }

    String userID = FirebaseAuth.instance.currentUser!.uid;
    String nickname = nicknameController.text;
    String deviceID = "";
    int icon = selectedIcon.index;
    await getDeviceUniqueId().then((value) => deviceID = value);



    _socketClient.emit('createNewAccount', {
      "newUserID": userID,
      "newNickname" : nickname,
      "newIcon" : icon,
      "deviceID" : deviceID
    });

  }

  Future<String> getDeviceUniqueId() async {
    var deviceIdentifier = 'unknown';
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
      print(androidInfo.id);
    } else if (Platform.isIOS) {

      //キーチェーンにuuidが登録されているか確認
      final storage = new FlutterSecureStorage();
      String? idToken = await storage.read(key: 'quichaUUID');
      //なかったら新規登録
      if(idToken == null){
        final String UUID = Uuid().v4();
        await storage.write(key: 'quichaUUID', value: UUID);
      }

       idToken = await storage.read(key: 'quichaUUID');
      print(idToken!);
      deviceIdentifier = idToken!;
    }

    return deviceIdentifier;
  }



}

