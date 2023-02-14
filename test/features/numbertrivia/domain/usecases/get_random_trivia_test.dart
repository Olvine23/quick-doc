// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:test/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockRandomTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockRandomTriviaRepository mockRandomTriviaRepository;

  setUp(() {
    mockRandomTriviaRepository = MockRandomTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRandomTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: "hello", number: 5);

  test('gets a random trivia number', () async {

    // "On the fly" implementation of the Repository using the Mockito package.
      // When getRandomNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.


    when(mockRandomTriviaRepository.getRandomNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));

        // The "act" phase of the test. Call the not-yet-existent method.

    final res = await usecase(Params(number: tNumber));

    // UseCase should simply return whatever was returned from the Repository

    expect(res, Right(tNumberTrivia));
    verify(mockRandomTriviaRepository.getRandomNumberTrivia(tNumber));
    verifyNoMoreInteractions(MockRandomTriviaRepository());
  });

  group('toJson', (){
   
  });
}
