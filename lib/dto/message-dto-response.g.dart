// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message-dto-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDtoResponse _$MessageDtoResponseFromJson(Map<String, dynamic> json) {
  return MessageDtoResponse(
    json['body'] == null
        ? null
        : MessageDto.fromJson(json['body'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$MessageDtoResponseToJson(MessageDtoResponse instance) =>
    <String, dynamic>{
      'body': instance.body?.toJson(),
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
