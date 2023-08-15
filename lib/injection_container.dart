import 'package:assignments/feature/quiz/data/datasources/quiz_remote_datasource.dart';
import 'package:assignments/feature/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:assignments/feature/quiz/domain/repositories/quiz_repository.dart';
import 'package:assignments/feature/quiz/domain/usecases/get_all_quiz.dart';
import 'package:assignments/feature/quiz/presentation/bloc/cubit/quiz_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

//manual inject

Future<void> init() async {
  // Bloc/Cubit
  sl.registerFactory(
    () => QuizCubit(getAllQuizUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllQuizUseCase(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(quizRemoteDatasource: sl()),
  );
}
