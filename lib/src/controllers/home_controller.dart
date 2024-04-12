import 'package:estudando/src/repositories/ebook_repository.dart';
import 'package:flutter/material.dart';

import '../models/ebook_model.dart';

class HomeController extends ChangeNotifier {
  final EbookRepository service;

  HomeController(this.service);

  var ebooks = <EbookModel>[];
  var favorites = <EbookModel>[];

  Future<void> fetchAllEbooks() async {
    ebooks = await service.getEbooks();
    notifyListeners();
  }

  bool isFavorite(EbookModel ebook) {
    return favorites.contains(ebook);
  }

  void toggleFavorite(EbookModel ebook) {
    if (favorites.contains(ebook)) {
      favorites.remove(ebook);
    } else {
      favorites.add(ebook);
    }
    notifyListeners();
  }

  void removeFavorites(EbookModel ebook) {
    if (favorites.contains(ebook)) {
      favorites.remove(ebook);
      notifyListeners();
    }
  }
}
