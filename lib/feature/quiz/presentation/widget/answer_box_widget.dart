import 'package:assignments/core/constants/const_keys.dart';
import 'package:assignments/feature/quiz/domain/entities/quiz.dart';
import 'package:assignments/feature/quiz/presentation/widget/answer_chip_widget.dart';
import 'package:flutter/material.dart';

class AnswerBoxWidget extends StatefulWidget {
  final Quiz quiz;
  final Function(String choice)? removeChoice;
  final bool validate;
  const AnswerBoxWidget(
      {super.key,
      required this.quiz,
      this.removeChoice,
      required this.validate});

  @override
  State<AnswerBoxWidget> createState() => _AnswerBoxWidgetState();
}

class _AnswerBoxWidgetState extends State<AnswerBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(30),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 6.0,
              children: listTextWidget(
                  quiz: this.widget.quiz, validate: this.widget.validate),
            ),
          )),
    );
  }

  List<Widget> listTextWidget({required Quiz quiz, required bool validate}) {
    List<Widget> listWidget = [];
    List<String> splitted = quiz.text.split('|');
    int indexPosition = 0;
    List<String> sortAnswers = quiz.text.split('|');
    sortAnswers.removeWhere((item) => !item.contains('#'));

    for (String word in splitted) {
      if (word.contains('_')) {
        indexPosition += 1;
        listWidget.add(Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Container(
            width: 40.0,
            height: 30.0,
            decoration: new BoxDecoration(
              color: Colors.deepPurpleAccent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ));
      } else if (word.contains('#')) {
        indexPosition += 1;
        int position = indexPosition;
        List<String> listWords = word.split('#');
        String rawWord = listWords[1];
        listWidget.add(AnswerChipWidget(
          title: rawWord,
          customValidator: () {
            if (sortAnswers.length == quiz.solutions.length || validate) {
              int correctWordIndex = quiz.solutions[position - 1];
              int choiceIndex = quiz.choices.indexOf(rawWord);
              return (correctWordIndex == choiceIndex)
                  ? QUIZ_STATUS.CORRECT
                  : QUIZ_STATUS.WRONG;
            }
            return null;
          },
          onSelected: (value) {
            if (this.widget.removeChoice != null) {
              this.widget.removeChoice!(value);
            }
          },
        ));
      } else {
        listWidget.add(SelectableText.rich(TextSpan(
          text: word,
          style: TextStyle(
            fontSize: 20,
          ),
        )));
      }
    }

    return listWidget;
  }
}
