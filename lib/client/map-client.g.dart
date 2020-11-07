// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map-client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MapClient implements MapClient {
  _MapClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.31.152:8010/api/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<PointDto>> getPoints() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/point2',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => PointDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
