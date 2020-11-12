// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-dto-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDtoResponse _$UserDtoResponseFromJson(Map<String, dynamic> json) {
  return UserDtoResponse(
    json['body'] == null
        ? null
        : UserDto.fromJson(json['body'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$UserDtoResponseToJson(UserDtoResponse instance) =>
    <String, dynamic>{
      'body': instance.body?.toJson(),
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
