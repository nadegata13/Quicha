enum MessageType{
  text,
  image,
  sound;
  static MessageType getType(int index){
    for(var icon in MessageType.values){
      if(icon.index == index) {
        return icon;
        }
  }
return MessageType.text;
}
}

class QuizManMessage{
  String message;
  MessageType type;
  QuizManMessage({required this.message, required this.type});
}

class QuizMan{

  List<QuizManMessage> _messages = [];
  int _index = 0;
  bool isLastIndex = false;
  QuizManMessage _newMessage = QuizManMessage(message: "初期値", type: MessageType.text);


  void setMessages({required List<QuizManMessage> messages}){
    this._messages = messages;
    _index = 0;
    isLastIndex = false;
  }

  QuizManMessage getNewMessage() {
    _newMessage = _messages[_index];
    _countUpIndex();

    if(_messages.length - 1 < _index) {
      isLastIndex = true;
    }
    return _newMessage;
  }

  void _countUpIndex(){

    if(isLastIndex) { return; }

    _index++;
  }


  void startCountDown(){
    print("カウントダウン");

  }

  void resetCountDown() {
    print("リセット");
  }


}