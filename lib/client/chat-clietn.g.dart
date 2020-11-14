// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat-clietn.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ChatClient implements ChatClient {
  _ChatClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.31.154:8020/api/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<UserDtoResponse> createUser(userDto) async {
    ArgumentError.checkNotNull(userDto, 'userDto');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userDto?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserDtoResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageDtoResponse> getMessage(uuid) async {
    ArgumentError.checkNotNull(uuid, 'uuid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/message/$uuid',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageDtoResponse.fromJson(_result.data);
    return value;
  }
}
