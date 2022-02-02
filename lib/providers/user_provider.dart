import 'package:flutter/material.dart';
import 'package:flutter_insta/resources/auth_methods.dart';

import '../models/app_user.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();
  AppUser? _user;

  AppUser get getUser => _user!;

  Future<void> refreshUser() async {
    AppUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
