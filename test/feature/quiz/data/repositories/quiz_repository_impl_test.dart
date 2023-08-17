import 'dart:convert';

import 'package:assignments/feature/quiz/data/datasources/quiz_remote_datasource.dart';
import 'package:assignments/feature/quiz/data/models/quiz_model.dart';
import 'package:assignments/feature/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../mockdata/const_mock.dart';
import 'quiz_repository_impl_test.mocks.dart';

@GenerateMocks([QuizRemoteDatasource])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockQuizRemoteDatasource mockQuizRemoteDatasource;
  late QuizRepositoryImpl quizRepositoryImpl;

  setUp(() {
    mockQuizRemoteDatasource = MockQuizRemoteDatasource();
    quizRepositoryImpl =
        QuizRepositoryImpl(quizRemoteDatasource: mockQuizRemoteDatasource);
  });

  group("QuizRepository getAllQuiz", (() {
    test("Repo getAllQuiz success", (() async {
      String data = await rootBundle.loadString('assets/data.json');
      List<dynamic> list = json.decode(data);

      List<QuizModel> listModel = [];
      for (Map<String, dynamic> item in list) {
        QuizModel quiz = QuizModel.fromJson(item);
        listModel.add(quiz);
      }

      when(mockQuizRemoteDatasource.getAllQuiz())
          .thenAnswer((_) => Future.value(listModel));
      final result = await quizRepositoryImpl.getAllQuiz();

      expect(result, Right(listModel));
    }));

    test("Repo getAllQuiz ServerException", (() async {
      when(mockQuizRemoteDatasource.getAllQuiz())
          .thenThrow(ConstMock.serverException);
      final result = await quizRepositoryImpl.getAllQuiz();

      expect(result, ConstMock.serverFailure);
    }));

    test("Repo getAllQuiz CacheException", (() async {
      when(mockQuizRemoteDatasource.getAllQuiz())
          .thenThrow(ConstMock.cacheException);
      final result = await quizRepositoryImpl.getAllQuiz();

      expect(result, ConstMock.cacheFailure);
    }));
  }));
}
