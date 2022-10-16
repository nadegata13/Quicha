
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final homePorovider = ChangeNotifierProvider((ref) {
  return HomeNotifier();
});


class HomeNotifier extends ChangeNotifier {

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
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200),() {
      isClicked = false;
      notifyListeners();
    });
  }


}
