// To parse this JSON data, do
//
//     final Poems = PoemsFromJson(jsonString);

import 'dart:convert';

List<Poems> PoemsFromJson(String str) =>
    List<Poems>.from(json.decode(str).map((x) => Poems.fromJson(x)));

String PoemsToJson(List<Poems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Poems {
  Poems({
    required this.title,
    required this.author,
    required this.lines,
    required this.linecount,
  });

  String title;
  String author;
  List<String> lines;
  String linecount;

  factory Poems.fromJson(Map<String, dynamic> json) => Poems(
        title: json["title"],
        author: json["author"],
        lines: List<String>.from(json["lines"].map((x) => x)),
        linecount: json["linecount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "lines": List<dynamic>.from(lines.map((x) => x)),
        "linecount": linecount,
      };
}
