import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:redoonai/config/api_urls.dart';
import 'package:redoonai/config/global.dart';
import 'package:redoonai/config/log_util.dart';
import 'package:redoonai/http/request_interceptor.dart';
import 'package:redoonai/models/result.dart';

/// API: 数据请求接口
class Api {
  static const String testHost = 'https://api.lingliai.com';
  static const String productHost = 'https://api.moebeast.com';
  //https://api.lingliai.com
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Api([this.context]) {
    _options = Options(extra: {'context': context});
  }

  BuildContext? context;
  late Options _options;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: '$productHost/v1.0',
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
      // receiveDataWhenStatusError: true
    ),
  );

  static resetBaseUrl() {
    dio.options.baseUrl =
    Global.netEnvTest ? '$testHost/v1.0' : '$productHost/v1.0';
  }

  static void init() {
    // 添加缓存插件
    // dio.interceptors.add(Global.cacheInterceptor);
    // 添加请求插件
    dio.interceptors.add(RequestInterceptors());
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  /// Get方法
  Future<Map<String, dynamic>> get(pathName,
      {Map<String, dynamic>? queryParameters, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra!.addAll({'refresh': true, 'list': true});
    }
    var result = await dio.get(apiUrls[pathName]!,
        queryParameters: queryParameters, options: _options);

    // 检测结果
    if (result.statusCode == 200) {
      LogUtil.v('Get Result >>>>> ${result.data}\n');
      return result.data;
    } else {
      throw Exception('Request ${apiUrls[pathName]} Api failed!');
    }
  }

  /// Get方法
  Future<Map<String, dynamic>> getWithUrl(url,
      {Map<String, dynamic>? queryParameters, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra!.addAll({'refresh': true, 'list': true});
    }
    try {
      var result = await dio.get(url!,
          queryParameters: queryParameters, options: _options);

      // 检测结果
      if (result.statusCode == 200) {
        LogUtil.v('Get Result >>>>> ${result.data}\n');
        return result.data;
      } else {
        throw Exception('Request Api failed!');
      }
    } catch (e) {
      return {};
    }
  }

  /// Get方法
  Future<Result> getResult(pathName,
      {Map<String, dynamic>? queryParameters, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra!.addAll({'refresh': true, 'list': true});
    }
    var result = await dio.get(apiUrls[pathName]!,
        queryParameters: queryParameters, options: _options);

    // 检测结果
    if (result.statusCode == 200) {
      LogUtil.v('Get Result >>>>> ${result.data}\n');
      return result.data;
    } else {
      throw Exception('Request Api failed!');
    }
  }

  /// Post方法
  Future<Map<String, dynamic>> post(pathName,
      {Map<String, dynamic>? data}) async {
    // LogUtil.v('Post data >>>>> $data');
    // FormData _formData = FormData.fromMap(data);
    var result = await dio.post(apiUrls[pathName]!, data: data);
    LogUtil.v('Post result >>>>> $result\n');
    return result.data;
  }

  /// 登录接口，登录成功后返回用户信息
  Future<Map<String, dynamic>> login(String account, String pwd) async {
    String basic = 'Basic ${base64.encode(utf8.encode('$account:$pwd'))}';

    try {
      _options.headers = {HttpHeaders.authorizationHeader: basic};
      _options.extra = {
        'noCache': true, // 本接口禁用缓存
      };
      var result = await dio.post(
        apiUrls['auth_login']!,
        options: _options
      );
      LogUtil.v('Login result >>>>> $result');
      return result.data;
    } on DioException {
      rethrow;
    }
  }

}
