import 'package:assignments/core/error/exception.dart';
import 'package:assignments/feature/quiz/data/models/quiz_model.dart';
import 'package:flutter/services.dart';

abstract class QuizRemoteDatasource {
  Future<List<QuizModel>> getAllQuiz();
}

class QuizRemoteDatasourceImpl extends QuizRemoteDatasource {
  @override
  Future<List<QuizModel>> getAllQuiz() async {
    // simulate ger response json from api
    try {
      String data = await rootBundle.loadString('assets/data.json');

      return [];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
