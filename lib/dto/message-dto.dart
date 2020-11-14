import 'package:json_annotation/json_annotation.dart';

part 'message-dto.g.dart';

@JsonSerializable()
class MessageDto{
  final int id;
  final String sender;
  final String recipient;
  final String message;

  MessageDto( this.sender, this.recipient, this.message, {this.id});

  factory MessageDto.fromJson(Map<String, dynamic> json) => _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}