import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

void main() {
  group('TodoPage widget', () {
    testWidgets('должен правильно рендерить список моделей Todo',
        (widgetTester) async {
      //  arrange
      const todoPageWidget = TodoPage(title: 'Todo List');

      //  act
      await widgetTester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: todoPageWidget,
        ),
      ));

      //  assert
      final actualFinder = find.byType(TodoPage);
      await expectLater(
        actualFinder,
        matchesGoldenFile('templates/todo_page.png'),
      );
    });
  });
}
