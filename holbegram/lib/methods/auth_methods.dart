import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/methods/user_storage.dart';
import 'dart:typed_data';
import 'package:holbegram/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();


  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return e.toString();
    }

    return 'Success';
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      Uint8List? file}) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final photoUrl = await _storageMethods.uploadImageToStorage(false, 'profile', file!);
      final UserModel user = UserModel(
        uid: userCredential.user?.uid,
        username: username,
        email: email,
        photoUrl: photoUrl,
      );
      await _firestore.collection('users').doc(user.uid).set(user.toFirestore());
    } catch (e) {
      return e.toString();
    }

    return 'Success';
  }

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnapshot(documentSnapshot);
  }
}
