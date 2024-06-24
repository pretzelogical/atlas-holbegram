import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch (e) {
      return e.toString();
    }

    return 'Success';
  }
}