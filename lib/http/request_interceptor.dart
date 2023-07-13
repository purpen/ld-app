import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:redoonai/config/global.dart';
import 'package:redoonai/config/log_util.dart';
import 'package:redoonai/http/data_helper.dart';

/// @desc 请求拦截器
class RequestInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    LogUtil.v('=======================================');
    LogUtil.v(
        'Request URL [${options.method}]: ${options.baseUrl}${options.path}, params: ${options.queryParameters}, data: ${options.data}');

    // 参数处理
    options.queryParameters.forEach((key, value) {
      if (options.path.contains(key)) {
        options.path = options.path.replaceAll(':$key', value.toString());
      }
    });

    // 第三方无需添加后端签名验证
    if (options.extra['x3rd'] == null) {
      // 添加sign参数
      Map<String, dynamic> paramsWithSign =
      DataHelper.encryptParams(options.queryParameters, data: options.data);
      options.queryParameters = paramsWithSign;
    }

    // 添加Token
    LogUtil.v('登录用户Token: ${Global.profile.token}');
    if (Global.profile.token != null) {
      String basic = 'Basic ${base64.encode(
              utf8.encode('${Global.profile.token}:${Global.profile.token}'))}';
      options.headers['authorization'] = basic;
    }

    // LogUtil.v('Request sign params：${options.queryParameters}');
    // LogUtil.v('Request headers：${options.headers}');

    handler.next(options);
  }
}
