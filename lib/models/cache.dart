import 'package:json_annotation/json_annotation.dart';

part 'cache.g.dart';

@JsonSerializable()
class Cache {
  Cache();

  bool? enable;
  num? max_age;
  num? max_count;
  
  factory Cache.fromJson(Map<String,dynamic> json) => _$CacheFromJson(json);
  Map<String, dynamic> toJson() => _$CacheToJson(this);
}
