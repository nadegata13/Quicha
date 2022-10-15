import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quicha/character_icons.dart';

class NewAccountViewModel extends ChangeNotifier{

  final isFillNickname = false;
  TextEditingController nicknameController = TextEditingController();
  CharacterIcons selectedIcon = CharacterIcons.default_human;

  void setIcon({required icon}) {
    this.selectedIcon = icon;
    notifyListeners();
  }



}
