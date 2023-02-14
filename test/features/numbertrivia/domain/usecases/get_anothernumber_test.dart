import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:test/features/number_trivia/domain/usecases/get_another_number.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetAnotherNumber usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetAnotherNumber(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: "test", number: 2);

  test('get another number', () async {
    when(mockNumberTriviaRepository.getAnotherNumber(any))
        .thenAnswer((_) async => Right(tNumberTrivia));

    final result = await usecase(Params(number: tNumber));

    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getAnotherNumber(tNumber));

    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
