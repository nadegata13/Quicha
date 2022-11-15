class QuizMan{

  List<String> _messages = [];
  int _index = 0;
  String _newMessage = "";

  bool isLastIndex = false;

  void setMessages({required List<String> messages}){
    this._messages = messages;
    _index = 0;
    isLastIndex = false;
  }

  String getNewMessage() {
    _newMessage = _messages[_index];
    _countUpIndex();

    if(_messages.length - 1 < _index) {
      isLastIndex = true;
    }
    return _newMessage;
  }

  void _countUpIndex(){
    _index++;
  }


  void startCountDown(){
    print("カウントダウン");

  }

  void resetCountDown() {
    print("リセット");
  }


}