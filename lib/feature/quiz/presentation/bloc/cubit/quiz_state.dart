part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends QuizState {}

class Loading extends QuizState {}

class Loaded extends QuizState {
  final Quiz quiz;
  List<String> answers;
  QUIZ_STATUS status;
  final bool validate;

  Loaded(
      {required this.quiz,
      required this.answers,
      this.status = QUIZ_STATUS.EMPTY,
      this.validate = false});

  @override
  List<Object> get props => [quiz, answers];
}

class Error extends QuizState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
