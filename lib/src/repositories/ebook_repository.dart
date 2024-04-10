import 'package:dio/dio.dart';
import 'package:estudando/src/models/ebook_model.dart';

class EbookRepository {
  final url = 'https://escribo.com/books.json';
  final dio = Dio();

  Future<List<EbookModel>> getEbooks() async {
    final response = await dio.get(url);
    final body = response.data as List;
    final ebooks = body
        .map(
          (map) => EbookModel(
            title: map['title'],
            author: map['author'],
            cover_url: map['cover_url'],
            download_url: map['download_url'],
          ),
        )
        .toList();
    return ebooks;
  }
}
