import 'dart:convert';

class Ebook {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  Ebook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });
  
  Ebook copyWith({
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
  }) =>
      Ebook(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverUrl: coverUrl ?? this.coverUrl,
        downloadUrl: downloadUrl ?? this.downloadUrl,
      );

  factory Ebook.fromRawJson(String str) => Ebook.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ebook.fromJson(Map<String, dynamic> json) => Ebook(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "cover_url": coverUrl,
        "download_url": downloadUrl,
      };
}
