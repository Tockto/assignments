import 'package:assignments/core/constants/const_keys.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  final String text;
  final List<String> choices;
  final List<int> solutions;

  const QuizModel(this.text, this.choices, this.solutions)
      : super(text, choices, solutions);

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        json[ConstKeys.quizText] as String,
        json[ConstKeys.quizChoices] as List<String>,
        json[ConstKeys.quizChoices] as List<int>,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        ConstKeys.quizText: this.text,
        ConstKeys.quizChoices: this.choices,
        ConstKeys.quizSolutions: this.solutions,
      };
}
