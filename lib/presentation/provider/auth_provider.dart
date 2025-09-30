import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/entities/user_entity.dart';
import '../../data/usecase/auth/firebase/get_current_user.dart';
import '../../data/usecase/auth/firebase/login_user.dart';
import '../../data/usecase/auth/firebase/register_firebase_user.dart';
import '../../data/usecase/auth/get_sql_user.dart';
import '../../data/usecase/auth/local/register_backend_user.dart';
import '../../data/usecase/auth/logout_user.dart';
import '../../data/usecase/auth/register_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;
  final RegisterBackendUser registerBackend;
  final RegisterFirebaseUser registerFirebaseUser;
  final GetSqlUser getSqlUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthStatus status = AuthStatus.initial; // 👈 Start as loading for Splash
  UserEntity? currentUserEntity;
  User? currentUser;
  bool isInitialized = false;
  String? errorMessage;

  AuthProvider({
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
    required this.getCurrentUser,
    required this.registerFirebaseUser,
    required this.registerBackend,
    required this.getSqlUser,
  });

  // 🚀 Register new user
  Future<void> register(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    _setLoading();
    try {
      final result = await registerUser.execute(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      result.fold(
        (failure) {
          errorMessage = failure.message;
          status = AuthStatus.error;
        },
        (userEntity) {
          currentUserEntity = userEntity;
          status = AuthStatus.authenticated;
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      status = AuthStatus.error;
    }
    notifyListeners();
  }

  // Login user
  Future<void> login(String email, String password) async {
    _setLoading();
    try {
      final result = await loginUser.execute(email, password);

      result.fold(
        (failure) {
          errorMessage = failure.message;
          status = AuthStatus.error;
        },
        (userCredential) {
          currentUser = userCredential.user;
          status = AuthStatus.authenticated;
        },
      );
    } catch (e) {
      errorMessage = e.toString();
      status = AuthStatus.error;
    }

    notifyListeners();
  }

  // 🚀 Logout user
  Future<void> logout() async {
    _setLoading();
    final result = await logoutUser.execute();
    result.fold(
      (failure) {
        errorMessage = failure.message;
        status = AuthStatus.error;
      },
      (_) {
        currentUser = null;
        currentUserEntity = null;
        status = AuthStatus.unauthenticated;
      },
    );
    notifyListeners();
  }

  Future<void> loadUser() async {
    debugPrint("🔄 [AuthProvider] loadUser called...");
    status = AuthStatus.loading;
    notifyListeners();

    try {
      currentUser = await getCurrentUser();

      if (currentUser == null) {
        debugPrint("❌ [AuthProvider] No Firebase user found.");
        status = AuthStatus.unauthenticated;
      } else {
        debugPrint("✅ [AuthProvider] Firebase user: ${currentUser!.uid}");

        final result = await getSqlUser.execute(uid: currentUser!.uid);

        result.fold(
              (failure) {
            debugPrint("⚠️ [AuthProvider] Failed to fetch SQL user: ${failure.message}");
            errorMessage = failure.message;
            // Optional: keep status authenticated if Firebase user exists
          },
              (userEntity) {
                currentUserEntity = userEntity;
            debugPrint("🎉 [AuthProvider] SQL user loaded: "
                "id=${userEntity.userId}, "
                "name=${userEntity.fullName}, "
                "email=${userEntity.email}");
          },
        );

        status = AuthStatus.authenticated;
      }
    } catch (e) {
      debugPrint("🔥 [AuthProvider] Unexpected error in loadUser: $e");
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
