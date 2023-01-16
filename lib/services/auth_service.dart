import 'package:authentication_task/services/auth_provider.dart';
import 'package:authentication_task/services/auth_user.dart';
import 'package:authentication_task/services/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AppUser> createUser({
    required String userName,
    required String email,
    required String password,
  }) =>
      provider.createUser(
        userName: userName,
        email: email,
        password: password,
      );

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
