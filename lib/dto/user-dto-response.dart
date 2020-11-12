import 'package:json_annotation/json_annotation.dart';
import 'user-dto.dart';

part 'user-dto-response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDtoResponse {

  final UserDto body;
  final int errorCode;
  final String message;

  UserDtoResponse(this.body, this.errorCode, this.message);

  factory UserDtoResponse.fromJson(Map<String, dynamic> json) => _$UserDtoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoResponseToJson(this);
}