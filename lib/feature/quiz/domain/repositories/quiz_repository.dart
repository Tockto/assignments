import 'package:assignments/core/error/failures.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:dartz/dartz.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Quiz>>> getAllQuiz();
}
