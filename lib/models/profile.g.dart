// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..token = json['token'] as String?
  ..last_login = json['last_login'] as String?
  ..locale = json['locale'] as String?
  ..app_name = json['app_name'] as String?
  ..cache = json['cache'] == null
      ? null
      : Cache.fromJson(json['cache'] as Map<String, dynamic>);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'last_login': instance.last_login,
      'locale': instance.locale,
      'app_name': instance.app_name,
      'cache': instance.cache,
    };
