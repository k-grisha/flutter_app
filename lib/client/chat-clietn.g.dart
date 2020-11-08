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
  Future<void> createUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }
}
