import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String text;
  final List<String> choices;
  final List<int> solutions;

  const Quiz(this.text, this.choices, this.solutions);

  @override
  List<Object?> get props => [text, choices, solutions];
}
