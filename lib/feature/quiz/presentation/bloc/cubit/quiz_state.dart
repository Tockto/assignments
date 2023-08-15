part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends QuizState {}

class Loading extends QuizState {}

class Loaded extends QuizState {
  final List<Quiz> listQuiz;

  Loaded({required this.listQuiz});

  @override
  List<Object> get props => [listQuiz];
}

class Error extends QuizState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
