abstract class IHttpClient {
  IHttpClient(Type client);

  Future<dynamic> get(String url);
}
