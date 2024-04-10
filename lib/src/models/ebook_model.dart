// ignore_for_file: non_constant_identifier_names

class EbookModel {
  final String title;
  final String author;
  final String cover_url;
  final String download_url;

  EbookModel({
    required this.title,
    required this.author,
    required this.cover_url,
    required this.download_url,
  });

 static EbookModel fromJson(dynamic map) {
    return EbookModel(
      title: map['title'],
      author: map['author'],
      cover_url: map['cover_url'],
      download_url: map['download_url'],
    );
  }
}
