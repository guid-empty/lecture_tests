import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  goldenTest(
    'TodoItem widget',
    fileName: 'todo_item',
    builder: () => Material(
      color: Colors.transparent,
      child: GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: 'completed task',
            child: TodoItemWidget(
              item: const TodoModel(
                id: -1,
                title: 'CompletedTask',
                isCompleted: true,
              ),
              selected: false,
              onCheckBoxTap: (_) {},
            ),
          ),
          GoldenTestScenario(
            name: 'uncompleted task',
            child: TodoItemWidget(
              item: const TodoModel(
                id: -1,
                title: 'UncompletedTask',
                isCompleted: false,
              ),
              selected: false,
              onCheckBoxTap: (_) {},
            ),
          ),
          GoldenTestScenario(
            name: 'selected completed task',
            child: TodoItemWidget(
              item: const TodoModel(
                id: -1,
                title: 'CompletedTask',
                isCompleted: true,
              ),
              selected: true,
              onCheckBoxTap: (_) {},
            ),
          ),
          GoldenTestScenario(
            name: 'selected uncompleted task',
            child: TodoItemWidget(
              item: const TodoModel(
                id: -1,
                title: 'UncompletedTask',
                isCompleted: false,
              ),
              selected: true,
              onCheckBoxTap: (_) {},
            ),
          ),
        ],
      ),
    ),
  );
}
