import 'package:dio/dio.dart';
import 'package:flutter_app/dto/point-dto.dart';
import 'package:retrofit/retrofit.dart';

part 'map-client.g.dart';

@RestApi(baseUrl: "http://192.168.31.154:8010/api/v1")
abstract class MapClient {
  factory MapClient(Dio dio, {String baseUrl}) = _MapClient;

  @GET("/point")
  Future<List<PointDto>> getPoints();
}

