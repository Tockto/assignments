import 'dart:convert';

import 'package:assignments/core/error/exception.dart';
import 'package:assignments/feature/quiz/data/models/quiz_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class QuizRemoteDatasource {
  Future<List<QuizModel>> getAllQuiz();
}

@LazySingleton(as: QuizRemoteDatasource)
class QuizRemoteDatasourceImpl extends QuizRemoteDatasource {
  @override
  Future<List<QuizModel>> getAllQuiz() async {
    // simulate ger response json from api
    try {
      String data = await rootBundle.loadString('assets/data.json');
      List<dynamic> list = json.decode(data);

      // should saparate to ultil if have many list model
      List<QuizModel> result = [];
      for (Map<String, dynamic> item in list) {
        QuizModel quiz = QuizModel.fromJson(item);
        result.add(quiz);
      }

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
