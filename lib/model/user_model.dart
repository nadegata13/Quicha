import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/ui/character_icons.dart';

final myUserProvider = Provider(UserData.new);
final opponentUserProvider = Provider(UserData.new);



class UserData{
  String userID = "";
  String nickname = "name";
  int iconNum = CharacterIcons.default_azarashi.index;

  void setUserInfo({required String tmpUserID, required String tmpNickname, required int tmpIconNum} ){
    userID = tmpUserID;
    nickname = tmpNickname;
    iconNum = tmpIconNum;
  }

  final ProviderRef ref;

  UserData(this.ref){

  }

}