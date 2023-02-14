import 'package:hive/hive.dart';

part 'docs.g.dart';

@HiveType(typeId: 0)
class Docs {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final dynamic age;
  

  Docs(this.name, this.age,);
}
