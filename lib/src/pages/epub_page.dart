import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';

class EpubViewerPage extends StatefulWidget {
  final String downloadUrl;
  final String title;

  const EpubViewerPage({
    super.key,
    required this.downloadUrl,
    required this.title,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EpubViewerPageState createState() => _EpubViewerPageState();
}

class _EpubViewerPageState extends State<EpubViewerPage> {
  late Future<EpubBook> _documentFuture;
  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _documentFuture = _loadEpubDocument();
  }

  Future<EpubBook> _loadEpubDocument() async {
    final response = await Dio().get(
      widget.downloadUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    final Uint8List epubBytes = response.data as Uint8List;
    final EpubBook epubBook = await EpubReader.readBook(epubBytes);
    _epubController = EpubController(document: Future.value(epubBook));
    return epubBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<EpubBook>(
        future: _documentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar o livro EPUB'));
          } else {
            return EpubView(controller: _epubController);
          }
        },
      ),
    );
  }
}
