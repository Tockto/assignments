import 'package:assignments/core/config/configure_dependencies.dart';
import 'package:assignments/core/constants/const_keys.dart';
import 'package:assignments/feature/quiz/presentation/bloc/cubit/quiz_cubit.dart';
import 'package:assignments/feature/quiz/presentation/widget/answer_box_widget.dart';
import 'package:assignments/feature/quiz/presentation/widget/answer_chip_widget.dart';
import 'package:assignments/feature/quiz/presentation/widget/shake_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.title});
  final String title;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final animationKey = GlobalKey<ShakeAnimationWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => getIt<QuizCubit>()..getAllQuiz(),
        child: BlocConsumer<QuizCubit, QuizState>(
          listener: (context, state) {
            if (state is Loaded) {
              if (state.status == QUIZ_STATUS.WRONG) {
                animationKey.currentState?.shake();
              } else if (state.status == QUIZ_STATUS.CORRECT) {
                context.read<QuizCubit>().nextQuiz();
              }
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShakeAnimationWidget(
                        key: animationKey,
                        animationCount: 3,
                        animationOffset: 10,
                        animationDuration: Duration(milliseconds: 500),
                        child: AnswerBoxWidget(
                          quiz: state.quiz,
                          removeChoice: ((value) => context
                              .read<QuizCubit>()
                              .answerQuiz(
                                  quiz: state.quiz,
                                  choice: value,
                                  answerWords: state.answers)),
                        )),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: state.quiz.choices
                          .map((choice) => AnswerChipWidget(
                                title: choice,
                                isSelected: state.answers.contains(choice),
                                onSelected: ((value) => context
                                    .read<QuizCubit>()
                                    .answerQuiz(
                                        quiz: state.quiz,
                                        choice: value,
                                        answerWords: state.answers)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            } else {
              // error or another
              return Container();
            }
          },
        ),
      ),
    );
  }
}
