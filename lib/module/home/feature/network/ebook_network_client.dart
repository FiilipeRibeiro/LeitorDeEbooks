import '../../../../config/network.dart';
import '../../models/ebook.dart';
import 'ebook_network.dart';

class EbookNetworkClient extends EbookNetwork {
  final Network _network;

  EbookNetworkClient(this._network);

  @override
  Future<List<Ebook>> getEbooks() async {
    final result = await _network.get("/books.json");

    List<Ebook> ebooks = [];

    for (var element in result.data) {
      final parser = Ebook.fromJson(element);
      ebooks.add(parser);
    }

    return ebooks;
  }
}
