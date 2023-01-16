import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AppUser {
  final String? email;
  final String? userName;
  final String? uid;
  final bool isEmailVerified;

  const AppUser(
      {required this.userName,
      required this.uid,
      required this.email,
      required this.isEmailVerified});

  factory AppUser.fromFirebase(User user) => AppUser(
      email: user.email,
      isEmailVerified: user.emailVerified,
      uid: user.uid,
      userName: user.displayName);
}
