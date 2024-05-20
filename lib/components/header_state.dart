import 'package:flutter/material.dart';

class HeaderState extends ChangeNotifier {
  int _selectedIndex = 2;
  bool isLogin = false;

  int get selectedIndex => _selectedIndex;
  bool get login => isLogin;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // login
  void loginAccont() {
    isLogin = true;
    notifyListeners();
  }

  // logout
  void logoutAccount() {
    isLogin = false;
    notifyListeners();
  }
}
