//SocketMethodsで使う状態操作用のモデル

abstract class MatchingData {
   String matchingMessage;
   String connectClientCount;
   bool isVisibleBus;
   bool isAnimation;
   int opponentIcon;
   String opponentNickname;
   String opponentUserID;



  MatchingData({
   this.matchingMessage = "",
   this.connectClientCount = "",
    this.isVisibleBus = true,
    this.isAnimation = false,
    this.opponentIcon = 0,
    this.opponentNickname = "name",
    this.opponentUserID = ""
  });
}

class ClientCountData extends MatchingData {
  ClientCountData({super.connectClientCount});
}

class MatchedMessageData extends MatchingData {
  MatchedMessageData({super.matchingMessage});
}

class ReceiveUserData extends MatchingData {

  ReceiveUserData({super.opponentUserID, super.opponentNickname, super.opponentIcon, super.isAnimation, super.isVisibleBus});

  
}

