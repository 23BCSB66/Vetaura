import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = false;
    notifyListeners();
  }
}
