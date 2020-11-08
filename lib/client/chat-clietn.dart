import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'chat-clietn.g.dart';

@RestApi(baseUrl: "http://192.168.31.154:8020/api/v1")
abstract class ChatClient{
  factory ChatClient(Dio dio, {String baseUrl}) = _ChatClient;

  @POST("/user")
  Future<void> createUser();

}