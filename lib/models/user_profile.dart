import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  String _username = "Animal Lover";

  String get username => _username;

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}