import 'package:flutter/foundation.dart';

/// @desc  日志输出
class LogUtil {
  static const String _tagDefault = 'Ai >>>>> ';

  /// 是否 debug
  static bool debug = false; // 是否是debug模式, true: log v 不输出.

  static String tagDefault = _tagDefault;

  static void init({bool isDebug = false, String tag = _tagDefault}) {
    debug = isDebug;
    tag = tag;
  }

  static void e(Object object, {String tag = ''}) {
    _printLog(tag, ' ', object);
  }

  static void v(Object object, {String tag = ''}) {
    if (debug) {
      _printLog(tag, ' ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    StringBuffer sb = StringBuffer();
    sb.write('${DateTime.now()} ');
    sb.write((tag == null || tag.isEmpty) ? tagDefault : tag);
    sb.write(stag);
    sb.write(object);
    if (kDebugMode) {
      print(sb.toString());
    }
  }
}
