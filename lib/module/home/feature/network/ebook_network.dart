import '../../models/ebook.dart';

abstract class EbookNetwork {
  Future<List<Ebook>> getEbooks();
}
