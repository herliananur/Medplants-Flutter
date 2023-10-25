import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  bool goToMedScreen = false;

  void navigateToMedScreen() {
    goToMedScreen = true;
    notifyListeners();
  }
}
