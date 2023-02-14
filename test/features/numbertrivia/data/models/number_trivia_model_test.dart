import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  final tnumberTriviamodel = NumberTriviaModel(
    number: 1,
    text: "io",
  );
  test("should be a subclass of the number trivia entity. ", () async {
    expect(tnumberTriviamodel, isA<NumberTrivia>());
  });
}
