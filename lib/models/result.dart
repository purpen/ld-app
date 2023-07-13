/// Result: 返回结果格式
class Result<T> {
  Map<String, dynamic>? data;
  Status? status;
  bool? success;

  late T? dataModel;

  bool get isSuccess => success != null && success == true;

  Result({this.data, this.status, this.success});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!;
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class Status {
  int? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class ListModel<T> {
  List<T>? list;
  bool? more;
  late T Function(Map<String, dynamic> itemJson) parseItem;

  ListModel({this.list, this.more = false});

  ListModel.fromJson(
      Map<String, dynamic> json, {
        required T Function(Map<String, dynamic> itemJson) parseItem,
        String listKey = 'list',
      }) {
    List? mapList = json[listKey];
    list = mapList?.map<T>((e) => parseItem(e)).toList();

    more = json['more'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['data'] = list!.map((v) {
        return v is Map ? v : (v as dynamic).toJson();
      }).toList();
    }
    data['more'] = more;
    return data;
  }
}
