import 'package:hive/hive.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/books.dart';

final boxProvider = FutureProvider((ref) async {
  var box = await Hive.openBox<Books>('booksBox');
  print(box.values.length);
  return box;
});

final counterProvider = StateProvider((ref) => 66);
