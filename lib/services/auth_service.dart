import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    } catch (e) {
      print(e);
    }
  }
}
