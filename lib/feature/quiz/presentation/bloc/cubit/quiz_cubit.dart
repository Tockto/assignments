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
  bool validated = false;

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
      validated = false;
      emit(Loaded(
          quiz: listQuiz[currentQuiz], answers: [], validate: validated));
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
      validated = (answerWords.length == 0) ? false : validated;
      emit(Loaded(
          quiz: Quiz(newText, quiz.choices, quiz.solutions),
          answers: answerWords,
          validate: validated));
    } else {
      List<String> sortAnswers = newText.split('|');
      sortAnswers.removeWhere((item) => !item.contains('#'));
      QUIZ_STATUS quizStatus = QUIZ_STATUS.EMPTY;

      for (String answer in sortAnswers) {
        List<String> listWords = answer.split('#');
        String rawWord = listWords[1];
        int position = sortAnswers.indexOf(answer);
        int correctWordIndex = quiz.solutions[position];
        int choiceIndex = quiz.choices.indexOf(rawWord);

        quizStatus = (quizStatus == QUIZ_STATUS.WRONG)
            ? QUIZ_STATUS.WRONG
            : ((correctWordIndex == choiceIndex)
                ? QUIZ_STATUS.CORRECT
                : QUIZ_STATUS.WRONG);
      }
      validated = true;

      emit(Loaded(
          quiz: Quiz(newText, quiz.choices, quiz.solutions),
          answers: answerWords,
          status: quizStatus,
          validate: validated));
    }
  }
}
