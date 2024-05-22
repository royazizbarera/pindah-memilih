import 'package:flutter/material.dart';

class HeaderState extends ChangeNotifier {
  /// 0: Beranda
  /// 1: Pengajuan
  /// 2: Status Pengajuan
  /// 3: Informasi Pengajuan
  /// 4: Masuk
  /// 5: Daftar

  int _selectedIndex = 0;
  bool isLogin = false;
  String username = '';

  String get getUsername => username;

  int get selectedIndex => _selectedIndex;
  bool get login => isLogin;

  set setUsername(String name) {
    username = name;
    notifyListeners();
  }

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
