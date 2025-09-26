import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> register(String email, String password);
  Future<UserCredential> login(String email, String password);
  Future<void> logout();
  Future<User?> currentUser();
}


