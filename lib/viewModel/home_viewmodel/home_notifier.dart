import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/DateFormatter.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/socket_client.dart';
import 'home_state.dart';


final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
    ((ref) {
      ref.onDispose(() {
        SocketClient.instance.socket!.clearListeners();
        if(ref.notifier._timer != null){
          ref.notifier._timer.cancel();
        }
        print("disposed!");
      });
      return HomeNotifier();
    })
);

class HomeNotifier extends StateNotifier<HomeState> {

  late Socket _socketClient;
  late Timer _timer;
  //画面遷移用のアイコン
  int currentIcon = 0;


  HomeNotifier() : super(const HomeState()){
    _socketClient = SocketClient.instance.socket!;

    this._receiveEvent();

    //アカウント情報をサーバーに要求
    this._queryAccountInfo();

  }


  void test(){
    _queryAccountInfo();
  }

  void _receiveEvent() {

    //アカウント情報を受け取る;
    _socketClient.on("passAccountInfo", (data) {

      int _icon = data['icon'];
      int _lifeCount = data['lifeCount'];
      String _lifeUpdate = data['lifeUpdate'];

      String nickname = data['nickname'];
      String iconPath = CharacterIcons.getIcon(_icon).getPath;

      //画面遷移用のアイコンを設定
      currentIcon = _icon;
      state = state.copyWith(iconPath: iconPath, nickname: nickname );

      //ライフの確認
      _checkLife(lifeUpdateStr: _lifeUpdate, lifeCount: _lifeCount);
    });

    _socketClient.on("successUpdateLifeCount", (data){
      int lifeCount = data["lifeCount"];
      String lifeUpdate = data["lifeUpdate"];
      print(lifeCount);


      state = state.copyWith(lifeCount: lifeCount);
      _checkLife(lifeUpdateStr: lifeUpdate, lifeCount: lifeCount);

    });

  }
  void _checkLife({required String lifeUpdateStr, required int lifeCount}){

    int state_life_count = 0;
    String state_life_up_time = "";

    final int MAX_LIFE_COUNT = 5;

    state = state.copyWith(lifeCount: lifeCount, lifeUpTime: state_life_up_time);

    //ライフが5以上
    if(lifeCount >= MAX_LIFE_COUNT) {
      state_life_count = MAX_LIFE_COUNT;
      state_life_up_time = "";

      print("life is over 5");

      state = state.copyWith(lifeCount: state_life_count, lifeUpTime: state_life_up_time);

    } else {

      //ライフが5未満の場合

      //現在時刻
      var dateTimeNow = DateTime.now();

      //ライフ変更時間
      var lifeUpdateTime = DateFormatter.dateFormatter(lifeUpdateStr);

      //経過時間
      var passedSeconds = dateTimeNow.difference(lifeUpdateTime).inSeconds;

      print(passedSeconds);

      //一時保存用ライフカウント
      int tmpLifeCount = lifeCount;

      final int HOUR_TO_SECONDS = 3600;

      //1時間超過した回数を追加する。
      int hourCount = (passedSeconds   / HOUR_TO_SECONDS ).toInt();
      print("hourCount: " + hourCount.toString());
      tmpLifeCount += hourCount;


      //ライフMAX以上なら
      if(tmpLifeCount >= MAX_LIFE_COUNT) {
        //データベース上のライフを更新
        _updateLifeCount(lifeCount: MAX_LIFE_COUNT);
        print("life become 5");

        // return;
      }else {


        //3600秒 - 経過秒数　/ 3600b秒　の余り
        int restSeconds = (HOUR_TO_SECONDS - passedSeconds % HOUR_TO_SECONDS);
        print("restSeconds: " + restSeconds.toString() + ":" + tmpLifeCount.toString());

        //既にライフが増えていたらデータベースを更新
        if(lifeCount != tmpLifeCount) {
          _updateLifeCount(lifeCount: tmpLifeCount);
          return;
        }

        _countDownLifeUp(lifeUpTime: restSeconds, lifeCount: tmpLifeCount);

        print("life is under 5");

      }
    }
  }

  void _updateLifeCount({required int lifeCount}) {


    var currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser == null) { return; }
    print("_updateLifeCount : " + lifeCount.toString());

    _socketClient.emit('updateLifeCount', {
      "_userID" : currentUser.uid,
      "_lifeCount" : lifeCount,
    });

  }


  //ライフ復活時間までのカウントダウン
  void _countDownLifeUp({required int lifeUpTime, required int lifeCount}) async {

    _timer = Timer.periodic(Duration(seconds: 1), ((timer) {
      int restTime = lifeUpTime - timer.tick;

      if(restTime <= 0){
        lifeCount++;
        print("lifecount: " + lifeCount.toString());
        state = state.copyWith(lifeUpTime:  "");
        _updateLifeCount(lifeCount: lifeCount);

        timer.cancel();

        print("countDownLifeUp stopped");
      } else {
        int minutes = (restTime / 60).floor();
        int seconds = (restTime % 60);

        String minutesText = "";
        String secondsText = "";

        //2桁未満なら0を埋める
        if(minutes.toString().length < 2) {
          minutesText = "0" + minutes.toString();
        }else{
          minutesText = minutes.toString();
        }

        if(seconds.toString().length < 2){
          secondsText = "0" + seconds.toString();
        }else{
          secondsText = seconds.toString();
        }
        print(minutesText + ":" + secondsText);

        state = state.copyWith(lifeUpTime: minutesText + " : " + secondsText);
      }
    }));
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
