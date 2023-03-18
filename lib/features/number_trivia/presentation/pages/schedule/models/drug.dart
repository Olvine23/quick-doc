import 'package:hive/hive.dart';

part "drug.g.dart";

@HiveType(typeId: 5)
class Drug {
  @HiveField(0)
  String? drugName;
  @HiveField(1)
  DateTime? drugDate;
   

}
