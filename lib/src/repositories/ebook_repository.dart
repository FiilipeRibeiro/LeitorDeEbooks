import 'package:estudando/src/models/ebook_model.dart';
import 'http/http_client_interface.dart';

const url = 'https://escribo.com/books.json';

class EbookRepository {
  final IHttpClient client;

  EbookRepository(this.client);

  Future<List<EbookModel>> getEbooks() async {
    final body = await client.get(url);
    return (body as List).map(EbookModel.fromJson).toList();
  }
}
