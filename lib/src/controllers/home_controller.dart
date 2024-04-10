import 'package:estudando/src/repositories/ebook_repository.dart';
import 'package:flutter/material.dart';

import '../models/ebook_model.dart';

class HomeController extends ChangeNotifier {
  final EbookRepository _service;

  HomeController(this._service);

  var ebooks = <EbookModel>[];

  Future<void> fetchAllEbooks() async {
    ebooks = await _service.getEbooks();
    notifyListeners();
  }
}
