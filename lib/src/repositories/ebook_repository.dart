import 'package:dio/dio.dart';
import 'package:estudando/src/models/ebook_model.dart';

const url = 'https://escribo.com/books.json';

class EbookRepository {
  final Dio dio;

  EbookRepository(this.dio);

  Future<List<EbookModel>> getEbooks() async {
    final response = await dio.get(url);
    final body = response.data as List;
    return body.map(EbookModel.fromJson).toList();
  }
}
