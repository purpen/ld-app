// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cache _$CacheFromJson(Map<String, dynamic> json) => Cache()
  ..enable = json['enable'] as bool?
  ..max_age = json['max_age'] as num?
  ..max_count = json['max_count'] as num?;

Map<String, dynamic> _$CacheToJson(Cache instance) => <String, dynamic>{
      'enable': instance.enable,
      'max_age': instance.max_age,
      'max_count': instance.max_count,
    };
