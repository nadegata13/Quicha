import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quicha/character_icons.dart';

class HomeViewModel extends ChangeNotifier{

  var isClicked = false;

  void entryTapDown() {
    isClicked = true;
    notifyListeners();
  }
  void entryTapUp() {
    isClicked = false;
    notifyListeners();
  }
  void entryTapCancel() {
    isClicked = false;
    notifyListeners();
  }

  void clickedEntryButton() {
    isClicked = true;
    Future.delayed(const Duration(milliseconds: 200),() {
      isClicked = false;
      notifyListeners();
    });
    notifyListeners();
  }


}
