import 'package:authentication_task/firebase_options.dart';
import 'package:authentication_task/services/auth_exceptions.dart';
import 'package:authentication_task/services/auth_provider.dart';
import 'package:authentication_task/services/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AppUser> createUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': userName,
          'password': password,
        });
        return user;
      } else {
        throw userNotCreatedException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        print(e.code);
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AppUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AppUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<AppUser> login(
      {required String email, required String password}) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedinAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedOutException();
    }
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }
}
