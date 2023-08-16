import 'package:assignments/core/constants/const_keys.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  final String text;
  final List<String> choices;
  final List<int> solutions;

  QuizModel(
      {required this.text, required this.choices, required this.solutions})
      : super(text, choices, solutions);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    List<String> listChoices = [];
    List<int> listSolutions = [];

    if (json[ConstKeys.quizChoices] != null) {
      for (String choice in json[ConstKeys.quizChoices]) {
        listChoices.add(choice);
      }
    }

    if (json[ConstKeys.quizSolutions] != null) {
      for (int solution in json[ConstKeys.quizSolutions]) {
        listSolutions.add(solution);
      }
    }

    return QuizModel(
      text: json[ConstKeys.quizText] as String,
      choices: listChoices,
      solutions: listSolutions,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        ConstKeys.quizText: this.text,
        ConstKeys.quizChoices: this.choices,
        ConstKeys.quizSolutions: this.solutions,
      };
}
