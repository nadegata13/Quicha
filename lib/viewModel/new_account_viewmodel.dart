import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/ui/character_icons.dart';


final newAccountProvider = ChangeNotifierProvider((ref) {
  return NewAcountNotifier();
});

class NewAcountNotifier extends ChangeNotifier{

  final isFillNickname = false;
  TextEditingController nicknameController = TextEditingController();
  CharacterIcons selectedIcon = CharacterIcons.default_human;

  void setIcon({required icon}) {
    this.selectedIcon = icon;
    notifyListeners();
  }



}

class NewAccountViewModel extends ChangeNotifier{

  final isFillNickname = false;
  TextEditingController nicknameController = TextEditingController();
  CharacterIcons selectedIcon = CharacterIcons.default_human;

  void setIcon({required icon}) {
    this.selectedIcon = icon;
    notifyListeners();
  }



}
