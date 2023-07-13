import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late bool is_login;
  late String uid;
  late String username;
  late String email;
  String? mobile;
  late num gender;
  late String avatar;
  late bool is_bindWx;
  late num created_at;
  late num last_seen;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
