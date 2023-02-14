import 'package:hive/hive.dart';

part 'books.g.dart';

@HiveType(typeId: 1)
class Books {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? author;
  @HiveField(3)
  int? quantity;
  @HiveField(4)
  String? doc;
  @HiveField(5)
  DateTime? date;

  Books({this.id, this.author, this.title, this.quantity, this.doc, this.date});
}
