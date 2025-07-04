import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/data/todo_repository_refactored.dart';

void main() {
  group('TodoRepository', () {
    group('и его метод create', () {
      test(
        'должен выполнить обращение к TodoApi с правильными аргументами',
        () async {
          //  arrange
          const expectedTitle = 'Новая задача';
          const expectedIsCompleted = true;

          //  Так делать не нужно (((
          //  Стоит избегать реальных запросов в АПИ, в базу данных и тп
          final repository = TodoRepository(todoApi: TodoApi(dio: Dio()));

          //  act
          await repository.create(
            title: expectedTitle,
            isCompleted: expectedIsCompleted,
          );

          //  assert
          //  expect(??????)
          //  мы можем проверить только поведение, сам факт обращения к TodoAPI
        },
        skip: true,
      );
    });
  });
}
