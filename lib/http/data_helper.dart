import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:date_format/date_format.dart';
import 'package:redoonai/config/constants.dart';
import 'package:redoonai/config/log_util.dart';

/// @desc 请求参数工具类
class DataHelper {
  static SplayTreeMap getBaseMap() {
    var map = SplayTreeMap<String, dynamic>();
    map['app_key'] = Constants.appKey;
    map['nonce_str'] = randomString();
    map['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
    return map;
  }

  static encryptParams(Map<String, dynamic> map, {Map<String, dynamic>? data}) {
    var buffer = StringBuffer();
    // 添加基本参数
    var baseMap = getBaseMap();
    // 转成字符串
    List baseBuffer = [];
    baseMap.forEach((key, value) {
      baseBuffer.add('$key=$value');
    });
    buffer.write(baseBuffer.join('+'));
    // 加盐
    buffer.write(Constants.appSalt);
    // 添加密钥
    buffer.write(Constants.appSecret);

    LogUtil.v('签名字符串：${buffer.toString()}');

    var sign = stringSha1(buffer.toString());
    baseMap['sign'] = sign;

    // 合并get参数
    baseMap.addAll(map);
    // 合并post参数
    if (data != null && data.isNotEmpty) {
      baseMap.addAll(data);
    }

    return baseMap;
  }

  /// sha1加密
  static stringSha1(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = sha1.convert(content);
    return hex.encode(digest.bytes);
  }

  /// 生成随机字符
  static randomString() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';

    int strLength = 10;
    String rs = "";
    for (var i = 0; i < strLength; i++) {
      rs = rs + alphabet[Random().nextInt(alphabet.length)];
    }
    return rs;
  }

  /// 生成mock id
  static genMockId() {
    // 当前日期
    DateTime now = DateTime.now();
    String prefixDate =
    formatDate(now, ['yyyy', 'mm', 'dd', 'HH', 'nn', 'SSS']);
    return prefixDate + randomString();
  }

  /// 计数换算
  static String convertCountExp(int count) {
    return '${(count / 10000).toStringAsFixed(1)}w';
  }
}
