// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..is_login = json['is_login'] as bool
  ..uid = json['uid'] as String
  ..username = json['username'] as String
  ..email = json['email'] as String
  ..mobile = json['mobile'] as String?
  ..gender = json['gender'] as num
  ..avatar = json['avatar'] as String
  ..is_bindWx = json['is_bindWx'] as bool
  ..created_at = json['created_at'] as num
  ..last_seen = json['last_seen'] as num;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'is_login': instance.is_login,
      'uid': instance.uid,
      'username': instance.username,
      'email': instance.email,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'is_bindWx': instance.is_bindWx,
      'created_at': instance.created_at,
      'last_seen': instance.last_seen,
    };
