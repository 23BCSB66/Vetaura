import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isReady = true;

  bool get isAuthenticated => _isAuthenticated;
  bool get isReady => _isReady;

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = false;
    notifyListeners();
  }
}
