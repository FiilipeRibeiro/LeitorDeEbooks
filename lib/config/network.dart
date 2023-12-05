import 'package:dio/dio.dart';

abstract class Network {
  Future<Response> get(String url);
}
