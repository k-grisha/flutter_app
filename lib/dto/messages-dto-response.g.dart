// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages-dto-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesDtoResponse _$MessagesDtoResponseFromJson(Map<String, dynamic> json) {
  return MessagesDtoResponse(
    (json['body'] as List)
        ?.map((e) =>
            e == null ? null : MessageDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$MessagesDtoResponseToJson(
        MessagesDtoResponse instance) =>
    <String, dynamic>{
      'body': instance.body?.map((e) => e?.toJson())?.toList(),
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
