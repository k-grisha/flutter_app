// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) {
  return MessageDto(
    json['sender'] as String,
    json['recipient'] as String,
    json['message'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'recipient': instance.recipient,
      'message': instance.message,
    };
