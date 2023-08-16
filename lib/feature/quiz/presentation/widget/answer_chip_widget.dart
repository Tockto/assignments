import 'package:assignments/core/constants/const_keys.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AnswerChipWidget extends StatelessWidget {
  final Function(String choice)? onSelected;
  final String title;
  final bool isSelected;
  final int? indexPosition;
  QUIZ_STATUS? Function() customValidator;
  final player = AudioPlayer();

  AnswerChipWidget(
      {Key? key,
      this.onSelected,
      required this.title,
      this.isSelected = false,
      this.indexPosition,
      required this.customValidator})
      : super(key: key);

  Color dynamicColor() {
    if (customValidator() == QUIZ_STATUS.CORRECT) {
      return Colors.green;
    } else if (customValidator() == QUIZ_STATUS.WRONG) {
      return Colors.red;
    }
    return Colors.deepPurpleAccent;
  }

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
          color: dynamicColor(),
        ),
      ),
      onSelected: ((value) {
        player.play(AssetSource('vfx_tap.mp3'));
        if (onSelected != null) {
          onSelected!(title);
        }
      }),
    );
  }
}
