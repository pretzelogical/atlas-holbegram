import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(uid: '', username: '', email: '');
  final AuthMethods _authMethods = AuthMethods();

  UserModel get user => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}