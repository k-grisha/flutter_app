import 'package:flutter_app/dto/message-dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user-dto.dart';

part 'message-dto-response.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageDtoResponse {

  final MessageDto body;
  final int errorCode;
  final String message;

  MessageDtoResponse(this.body, this.errorCode, this.message);

  factory MessageDtoResponse.fromJson(Map<String, dynamic> json) => _$MessageDtoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoResponseToJson(this);
}