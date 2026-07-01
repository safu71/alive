import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    notifyListeners();


    final userCredential = await _authService.signInWithGoogle();

    _isLoading = false;
    notifyListeners();


    if (userCredential != null) {
      return true;
    } else {
      return false;
    }
  }
}
