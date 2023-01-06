import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        ref.notifier._socketMethods.close();
      });
      return MatchingNotifier(ref);
    })
);

final matchingSocketMethods = StreamProvider((ref){
  final ss = ref.read(matchingSocketProvider);
  return ss.socketResponse.stream;
});


class MatchingNotifier extends StateNotifier<MatchingState> {

    late Socket _socketClient;
    late Timer _timer;
    final StateNotifierProviderRef ref;

  MatchingNotifier( this.ref ) : super(const MatchingState()){

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

        state = state.copyWith(opponentNickname: opponentNickname, opponentIcon: opponentIcon,
        isAnimation: isAnimation, isVisibleBus: isVisibleBus);
      }
    });
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

  //マッチング時のアニメーション
  void test(){
    //TEST


    bool isVisibleBus = !state.isVisibleBus;
    print(isVisibleBus);

    bool isAnimation = !state.isAnimation;
    state = state.copyWith(isVisibleBus: isVisibleBus, isAnimation: isAnimation );
  }
    void initEntryRoom()  {
      entryRoby();


      ///REMOVE
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
