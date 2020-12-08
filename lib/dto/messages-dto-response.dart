import 'package:flutter_app/dto/message-dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages-dto-response.g.dart';

@JsonSerializable(explicitToJson: true)
class MessagesDtoResponse {
  final List<MessageDto> body;
  final int errorCode;
  final String message;

  MessagesDtoResponse(this.body, this.errorCode, this.message);

  factory MessagesDtoResponse.fromJson(Map<String, dynamic> json) => _$MessagesDtoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesDtoResponseToJson(this);
}
