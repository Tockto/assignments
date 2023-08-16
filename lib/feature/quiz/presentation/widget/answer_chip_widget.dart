import 'package:assignments/core/constants/const_keys.dart';
import 'package:flutter/material.dart';

class AnswerChipWidget extends StatelessWidget {
  final Function(String choice)? onSelected;
  final String title;
  final bool isSelected;
  QUIZ_STATUS status;
  final int? indexPosition;

  AnswerChipWidget({
    Key? key,
    this.onSelected,
    required this.title,
    this.isSelected = false,
    this.status = QUIZ_STATUS.EMPTY,
    this.indexPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      shape: StadiumBorder(side: BorderSide()),
      selected: isSelected,
      backgroundColor: Colors.white70,
      label: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: (status == QUIZ_STATUS.EMPTY)
              ? Colors.deepPurpleAccent
              : ((status == QUIZ_STATUS.CORRECT ? Colors.green : Colors.red)),
        ),
      ),
      onSelected: ((value) {
        if (onSelected != null) {
          onSelected!(title);
        }
      }),
    );
  }
}
