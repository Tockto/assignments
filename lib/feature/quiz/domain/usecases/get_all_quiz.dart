import 'package:assignments/core/error/failures.dart';
import 'package:assignments/core/usecase/usecase.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:assignments/feature/quiz/domain/repositories/quiz_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllQuizUseCase implements UseCase<List<Quiz>, NoParams> {
  final QuizRepository quizRepository;
  GetAllQuizUseCase(this.quizRepository);

  @override
  Future<Either<Failure, List<Quiz>>> call(NoParams params) async {
    return await quizRepository.getAllQuiz();
  }
}
