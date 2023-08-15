import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:assignments/feature/quiz/domain/usecases/get_all_quiz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final GetAllQuizUseCase getAllQuizUseCase;
  QuizCubit({required this.getAllQuizUseCase}) : super(Initial());
}
