import 'package:assignments/core/constants/const_keys.dart';
import 'package:assignments/core/usecase/usecase.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:assignments/feature/quiz/domain/usecases/get_all_quiz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'quiz_state.dart';

@injectable
class QuizCubit extends Cubit<QuizState> {
  final GetAllQuizUseCase getAllQuizUseCase;
  QuizCubit({required this.getAllQuizUseCase}) : super(Initial());
  List<Quiz> listQuiz = [];
  int currentQuiz = 0;

  Future<void> getAllQuiz() async {
    emit(Loading());
    final request = await getAllQuizUseCase(NoParams());
    request.fold((error) => emit(Error(message: error.message)), (list) {
      listQuiz = list;
      emit(Loaded(quiz: list[currentQuiz], answers: []));
    });
  }

  Future<void> nextQuiz() async {
    currentQuiz += 1;
    if ((listQuiz.length - 1) == currentQuiz) {
      emit(Loading());
      emit(Loaded(quiz: listQuiz[currentQuiz], answers: []));
    }
  }

  Future<void> answerQuiz(
      {required Quiz quiz,
      required String choice,
      required List<String> answerWords}) async {
    String newText = quiz.text;
    if (!quiz.text.contains('#$choice#')) {
      newText = quiz.text.replaceFirst('_', '#$choice#');
      if (answerWords.length < quiz.solutions.length) {
        answerWords.add(choice);
      }
    } else {
      newText = quiz.text.replaceFirst('#$choice#', '_');
      answerWords.removeWhere((word) => word.contains(choice));
    }

    if (answerWords.length != quiz.solutions.length) {
      emit(Loaded(
          quiz: Quiz(newText, quiz.choices, quiz.solutions),
          answers: answerWords));
    } else {
      List<String> sortAnswers = newText.split('|');
      sortAnswers.removeWhere((item) => !item.contains('#'));
      QUIZ_STATUS quizStatus = QUIZ_STATUS.EMPTY;

      for (int index in quiz.solutions) {
        for (String answer in sortAnswers) {
          if (answer.contains('#${quiz.choices[index]}#')) {
            quizStatus = QUIZ_STATUS.CORRECT;
          } else {
            quizStatus = QUIZ_STATUS.WRONG;
          }
        }
      }

      emit(Loaded(
          quiz: Quiz(newText, quiz.choices, quiz.solutions),
          answers: answerWords,
          status: quizStatus));
    }
  }
}
