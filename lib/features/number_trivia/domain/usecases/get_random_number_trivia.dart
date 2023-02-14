import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test/core/error/failures.dart';
import 'package:test/core/usecases/usecases.dart';
import 'package:test/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test/features/number_trivia/domain/repositories/number_trivia_repository.dart';
 

class GetRandomNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>?> call(Params params) async {
    return await repository.getRandomNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number});
  @override
  // TODO: implement props
  List<Object?> get props => [number];
}
