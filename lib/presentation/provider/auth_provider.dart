import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/usecase/auth/firebase/get_current_user.dart';
import '../../data/usecase/auth/firebase/login_user.dart';
import '../../data/usecase/auth/firebase/logout_user.dart';
import '../../data/usecase/auth/firebase/register_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;

  String? message;
  User? currentUser;
  AuthStatus status = AuthStatus.initial;
  String? errorMessage;


  bool isInitialized = false;
  bool isLoggedIn = false;

  AuthProvider({
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
    required this.getCurrentUser,
  }) {
    loadUser();
  }


  Future<void> register(String name, String email, String password) async {
    _setLoading();
    try {
      final userCredential = await registerUser(email, password);
      currentUser = userCredential.user;
      status = AuthStatus.authenticated;
    } catch (e) {
      errorMessage = e.toString();
      status = AuthStatus.error;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _setLoading();
    try {
      final userCredential = await loginUser(email, password);
      currentUser = userCredential.user;
      status = AuthStatus.authenticated;
    } catch (e) {
      errorMessage = e.toString();
      status = AuthStatus.error;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _setLoading();
    try {
      await logoutUser();
      currentUser = null;
      status = AuthStatus.unauthenticated;
    } catch (e) {
      errorMessage = e.toString();
      status = AuthStatus.error;
    }
    notifyListeners();
  }

  Future<void> loadUser() async {
    _setLoading();
    try {
      currentUser = await getCurrentUser();
      status = currentUser != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
    } catch (e) {
      status = AuthStatus.error;
    }
    isInitialized = true;
    notifyListeners();
  }

  void _setLoading() {
    status = AuthStatus.loading;
    errorMessage = null;
    notifyListeners();
  }
}
