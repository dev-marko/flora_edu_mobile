import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/flora_edu_user.dart';
import '../../../../storage/secure_storage.dart';

// unknown == initial
enum AuthStatus { unknown, authenticated, unauthenticated, registering }

class AuthRepository {
  final _storage = SecureStorage();
  final _streamController = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    yield AuthStatus.unknown;
    yield* _streamController.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var firebaseUser = FirebaseAuth.instance.currentUser;
      final user = FloraEduUser(
        id: firebaseUser!.uid,
        email: firebaseUser.email,
      );
      final token = await firebaseUser.getIdToken();
      _storage.saveEmailAndToken(user.email!, token!);
      _streamController.add(AuthStatus.authenticated);
    } on FirebaseAuthException catch (err) {
      print(err.code);
      // TODO: Throw different exceptions depending on the error code.
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _streamController.add(AuthStatus.unauthenticated);
    } on FirebaseAuthException catch (err) {
      print(err.code);
      // TODO: Throw different exceptions depending on the error code.
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> isLoggedIn() async {
    return await _storage.getToken() != null;
  }

  void setRegisteringStatus() {
    _streamController.add(AuthStatus.registering);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await _storage.clearStorage();
    _streamController.add(AuthStatus.unauthenticated);
  }

  void dispose() => _streamController.close();
}
