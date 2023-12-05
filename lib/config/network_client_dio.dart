import 'package:dio/dio.dart';

import 'network.dart';

//
class NetworkClientDio extends Network {
  final Dio _dio = Dio();

  NetworkClientDio() {
    _dio
      ..options.baseUrl = "https://escribo.com"
      ..options.responseType = ResponseType.json;
  }

  @override
  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      rethrow;
    }
  }
}
