import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

void main() {
  goldenTest(
    'TodoPage widget',
    fileName: 'todo_page',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'default state',
          child: SizedBox(
            width: 400,
            height: 600,
            child: TodoPage(
              title: 'Todo List',
              todoRepository: DI.todoRepository,
            ),
          ),
        ),
      ],
    ),
  );

  goldenTest(
    'TodoPage widget with completed task',
    fileName: 'todo_page_with_completed_task',
    whilePerforming: (WidgetTester tester) async {
      await tester.tap(
        find.byKey(const ValueKey('item_icon_1')),
      );
      await tester.pump(Durations.medium1);
      await tester.pump(Durations.medium1);
      return null;
    },
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'with completed task',
          child: SizedBox(
            width: 400,
            height: 600,
            child: TodoPage(
              title: 'Todo List',
              todoRepository: DI.todoRepository,
            ),
          ),
        ),
      ],
    ),
  );
}
