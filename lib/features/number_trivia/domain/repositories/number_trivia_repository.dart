import 'package:dartz/dartz.dart';
import 'package:test/core/error/failures.dart';
import 'package:test/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(any);
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia(any);
  Future<Either<Failure, NumberTrivia>>? getAnotherNumber(any);
}
