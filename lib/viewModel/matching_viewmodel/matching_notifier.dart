import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/user_model.dart';
import 'package:quicha/repository/socket_methods/matching_socket_methods.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/DateFormatter.dart';
import '../../model/matching_data.dart';
import '../../repository/socket_client.dart';

final matchingProvider = StateNotifierProvider.autoDispose<MatchingNotifier, MatchingState>(
    ((ref) {
      ref.onDispose(() {
        if(ref.notifier._timer != null) {

          ref.notifier._timer.cancel();
        }
      });
      return MatchingNotifier(ref);
    })
);

final matchingSocketMethods = StreamProvider((ref){
  final ss = ref.read(matchingSocketProvider);
  return ss.socketResponse.stream;
});


class MatchingNotifier extends StateNotifier<MatchingState> {

     Socket _socketClient = SocketClient.instance.socket!;
    late Timer _timer;
    final StateNotifierProviderRef ref;

  MatchingNotifier( this.ref ) : super(const MatchingState()){


    _socketClient.clearListeners();


    ref.listen(matchingSocketMethods, (AsyncValue<MatchingData>? _, AsyncValue<MatchingData> data) {
      var matchingData = data.value;

      if(matchingData is ClientCountData) {
        state = state.copyWith( connectClientCount: matchingData.connectClientCount );
      } else if (matchingData is MatchedMessageData) {

        //タイマー処理を止める
        if(_timer != null) {
          _timer.cancel();
        }

        
        state = state.copyWith(matchingMessage: matchingData.matchingMessage);
      } else if(matchingData is ReceiveUserData) {
        var opponentNickname = matchingData.opponentNickname;
        var opponentIcon = matchingData.opponentIcon;
        var isAnimation = matchingData.isAnimation;
        var isVisibleBus = matchingData.isVisibleBus;

        var opponentUserID = matchingData.opponentUserID;

        //相手ユーザープロバイダーを更新
        ref.read(opponentUserProvider).setUserInfo(tmpUserID: opponentUserID, tmpNickname: opponentNickname, tmpIconNum: opponentIcon);

        state = state.copyWith(opponentNickname: opponentNickname, opponentIcon: opponentIcon,
        isAnimation: isAnimation, isVisibleBus: isVisibleBus);
      }
    });

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

    /**
     * Socketメソッド
     */
    //レシーブイベント
    _onEvent();
    //ロビー入室
    _entryRoby();

  }

    MatchingSocketMethods get _socketMethods => ref.read(matchingSocketProvider);

  void _onEvent(){
    //接続数取得
    _socketMethods.onGetClientCount();
    //マッチングした時
    _socketMethods.onMatchedUser();
    //相手のプロフィール
    _socketMethods.onReceiveUserProfile();
  }

  void _entryRoby() {
    _socketMethods.entryRoby();
  }





  ///FIXME: userIDいらない
  void entryRoby() {
    _socketClient.emit('entryRoby', {
      'userId' : "12345",
    });
  }
  ///REMOVE AFTER
  void getMyRoom() {
    _socketClient.emit('getMyRoom');
  }




  void close(){
    _socketClient.emit('leaveRoom');
    _socketClient.clearListeners();
  }

  void showVsAnimation() {
    state = state.copyWith(isShowVsAnimation: true);
  }

}
