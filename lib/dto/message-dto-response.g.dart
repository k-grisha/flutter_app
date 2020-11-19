// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message-dto-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDtoResponse _$MessageDtoResponseFromJson(Map<String, dynamic> json) {
  return MessageDtoResponse(
    (json['body'] as List)
        ?.map((e) =>
            e == null ? null : MessageDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$MessageDtoResponseToJson(MessageDtoResponse instance) =>
    <String, dynamic>{
      'body': instance.body?.map((e) => e?.toJson())?.toList(),
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
