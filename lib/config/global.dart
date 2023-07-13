import 'dart:convert';
import 'package:redoonai/http/api.dart';
import 'package:redoonai/http/cache_interceptor.dart';
import 'package:redoonai/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @desc 全局配置
class Global {
  static late SharedPreferences _prefs;

  /// 持久化系统配置
  static Profile profile = Profile();

  /// 缓存管理
  static CacheInterceptor cacheInterceptor = CacheInterceptor();

  /// 测试环境
  static bool get netEnvTest => _netEnvTest;
  static bool _netEnvTest = false;

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (err) {
        print(err);
      }
    }

    var env = _prefs.getBool('netEnvTest');
    if (env != null) {
      _netEnvTest = env;
    }

    // 初始化网络请求相关配置
    Api.init();
  }

  // 持久化存储Profile信息
  static saveProfile() =>
      _prefs.setString('profile', jsonEncode(profile.toJson()));

  /// 持久化存储网络环境
  static set netEnvTest(bool e) {
    _netEnvTest = e;
    Api.resetBaseUrl();
    _prefs.setBool('netEnvTest', e);
  }
}
