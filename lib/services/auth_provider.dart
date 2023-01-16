import 'package:authentication_task/services/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AppUser? get currentUser;
  Future<AppUser> login({
    required String email,
    required String password,
  });
  Future<AppUser> createUser(
      {required String userName,
      required String email,
      required String password});
  Future<void> logout();
  Future<void> sendEmailVerification();
}
