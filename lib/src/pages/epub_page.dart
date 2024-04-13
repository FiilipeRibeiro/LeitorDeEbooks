import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';

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
  late String _pdfFilePath;

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

  Future<void> _convertEpubToPdf(Uint8List epubBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      _pdfFilePath = '${tempDir.path}/${widget.title}.pdf';

      final pdfDocument = PdfDocument();
      final pdfPage = pdfDocument.pages.add();

      final epubContent = String.fromCharCodes(epubBytes);

      pdfPage.graphics.drawString(
        epubContent,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(0, 0, pdfPage.getClientSize().width,
            pdfPage.getClientSize().height),
      );

      final file = File(_pdfFilePath);
      await file.writeAsBytes(await pdfDocument.save());
    } catch (e) {
      print('Erro ao converter EPUB para PDF: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao converter EPUB para PDF.'),
        ),
      );
    }
  }

  Future<void> _downloadEpub() async {
    // Verificar e solicitar permissão de armazenamento
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Obter o diretório de downloads
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory != null) {
        String epubFilePath = "${downloadsDirectory.path}/${widget.title}.epub";
        // Baixar o arquivo EPUB
        await Dio().download(widget.downloadUrl, epubFilePath);

        // Ler o conteúdo do arquivo EPUB
        final epubFile = File(epubFilePath);
        final epubBytes = await epubFile.readAsBytes();

        // Convertendo o arquivo EPUB para PDF
        await _convertEpubToPdf(epubBytes);

        // Exibir uma mensagem de sucesso
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Text('Arquivo EPUB instalado com sucesso!'),
                TextButton(
                  onPressed: () {
                    OpenFile.open(_pdfFilePath);
                  },
                  child: const Text('Abrir PDF'),
                ),
              ],
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível acessar o diretório de downloads.'),
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permissão de armazenamento negada.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadEpub,
          ),
        ],
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
