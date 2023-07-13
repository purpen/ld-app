import 'package:flutter/material.dart';
import 'package:redoonai/models/index.dart';

import '../config/global.dart';

class ProfileNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

/// 用户信息
class UserNotifier extends ProfileNotifier {
  // 获取用户信息
  User? get user => _profile.user;

  // 用户是否登录
  bool get isLogin => user != null && user!.is_login == true;

  // 用户信息发生变化
  set user(User? _user) {
    _profile.user = _user;
    notifyListeners();
  }
}

