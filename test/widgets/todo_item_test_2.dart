import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  group('TodoItem widget', () {
    testWidgets(
        'должен показать незавершенные Todo с иконкой check_box_outline_blank',
        (widgetTester) async {
      //  arrange
      const completedTodo = TodoModel(id: 1, title: '', isCompleted: false);
      final todoItemWidget = TodoItemWidget(
        item: completedTodo,
        selected: false,
        onCheckBoxTap: (_) {},
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoItemWidget,
        ),
      ));

      //  assert
      final iconFinder = find.byIcon(Icons.check_box_outline_blank);
      expect(iconFinder, findsOne);
    });

    testWidgets('должен показать выполненные Todo с иконкой check_box',
        (widgetTester) async {
      //  arrange
      const completedTodo = TodoModel(id: 1, title: '', isCompleted: true);
      final todoItemWidget = TodoItemWidget(
        item: completedTodo,
        selected: false,
        onCheckBoxTap: (_) {},
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoItemWidget,
        ),
      ));

      //  assert
      final iconFinder = find.byWidgetPredicate(
          (widget) => widget is Icon && widget.icon == Icons.check_box);
      expect(iconFinder, findsOne);
    });

    testWidgets(
        'должен показать незавершенный Todo с иконкой check_box_outline_blank',
        (widgetTester) async {
      //  arrange
      const completedTodo = TodoModel(id: 1, title: '', isCompleted: false);
      final todoItemWidget = TodoItemWidget(
        item: completedTodo,
        selected: false,
        onCheckBoxTap: (_) {},
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoItemWidget,
        ),
      ));

      //  assert
      final iconFinder = find.byWidgetPredicate((widget) =>
          widget is Icon && widget.icon == Icons.check_box_outline_blank);
      expect(iconFinder, findsOne);
    });

    testWidgets('должен показать перечеркнутый текст для выполненного Todo',
        (widgetTester) async {
      //  arrange
      const completedTodo = TodoModel(id: 1, title: '', isCompleted: true);
      final todoItemWidget = TodoItemWidget(
        item: completedTodo,
        selected: false,
        onCheckBoxTap: (_) {},
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoItemWidget,
        ),
      ));

      //  assert
      final textFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.style?.decoration == TextDecoration.lineThrough);
      expect(textFinder, findsOne);
    });
  });
}
