import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cache.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  User? user;
  String? token;
  String? last_login;
  String? locale;
  String? app_name;
  Cache? cache;
  
  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
