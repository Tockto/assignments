import 'package:assignments/core/error/exception.dart';
import 'package:assignments/feature/quiz/data/datasources/quiz_remote_datasource.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:assignments/core/error/failures.dart';
import 'package:assignments/feature/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDatasource quizRemoteDatasource;

  QuizRepositoryImpl({required this.quizRemoteDatasource});

  @override
  Future<Either<Failure, List<Quiz>>> getAllQuiz() async {
    try {
      List<Quiz> data = await quizRemoteDatasource.getAllQuiz();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message.toString()));
    }
  }
}
