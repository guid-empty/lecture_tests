import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/data/todo_repository.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';

void main() {
  group('TodoRepository', () {
    test(
      'и его метод fetchAll должен вернуть 5 задач в упорядоченном порядке',
      () {
        //  AAA - Arrange, Act, Assert
        //  arrange
        //  act
        //  assert
      },
    );

    test(
      'и его метод fetchAll должен вернуть 5 задач в упорядоченном порядке',
      () {
        //  arrange
        final repository = DI.todoRepository;

        //  act
        final actualTodos = repository.fetchAll();
        final actualIds = actualTodos.map((e) => e.id).toList().take(5);

        //  assert
        expect(actualIds.length, 5);
        //
        //  Expected: <6>
        //   Actual: <5>

        // expect(actualIds, hasLength(6));

        final expectedIds = [1, 2, 3, 4, 5];
        expect(actualIds, orderedEquals(expectedIds));
      },
    );

    group('и его метод create', () {
      test('должен создать новую задачу со следующим Id в списке ', () {
        //  arrange
        final repository = DI.todoRepository;

        //  act
        final expectedTodo = repository.create();

        //  assert
        final actualTodos = repository.fetchAll();
        expect(actualTodos.last, expectedTodo);
      });

      test('после создания задачи должен поместить ее в хранилище ', () {
        //  arrange
        final repository = DI.todoRepository;

        //  act
        final expectedTodo = repository.create();

        //  assert
        final actualTodos = repository.fetchAll();
        expect(actualTodos, contains(expectedTodo));
      });
    });

    group('и его метод removeById ', () {
      test('после удаления задачи должен удалить ее из хранилища ', () {
        //  arrange
        final repository = DI.todoRepository;

        //  act
        repository.removeById(1);

        //  assert
        final actualTodoIds = repository.fetchAll().map((e) => e.id);
        expect(actualTodoIds, isNot(contains(1)));
      });

      test(
        'при указании несуществующей задачи должен упасть с исключением',
        () {
          //  arrange
          final repository = DI.todoRepository;

          //  assert
          expect(
            () => repository.removeById(-1),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });

    group('и его метод completeTodo', () {
      test('должен перевести задачу в состояние Completed', () {
        //  arrange
        final repository = DI.todoRepository;
        final firstTodo = repository.fetchAll().first;

        //  act
        repository.completeTodo(firstTodo);

        //  assert
        final actualFirstTodo = repository.fetchAll().first;
        expect(actualFirstTodo.isCompleted, isTrue);
      });

      test(
        'при указании несуществующей задачи должен упасть с исключением',
        () {
          final repository = DI.todoRepository;

          //  assert
          expect(
            () => repository.completeTodo(TodoModel.unknown),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });

    group('и его метод unCompleteTodo', () {
      test('должен восстановить задачу в незавершенное состояние', () {
        //  arrange
        final repository = DI.todoRepository;
        var firstTodo = repository.fetchAll().first;
        repository.completeTodo(firstTodo);

        var actualFirstTodo = repository.fetchAll().first;
        expect(actualFirstTodo.isCompleted, isTrue);

        //  act
        firstTodo = repository.fetchAll().first;
        repository.unCompleteTodo(firstTodo);

        //  assert
        actualFirstTodo = repository.fetchAll().first;
        expect(actualFirstTodo.isCompleted, isFalse);
      });

      test(
        'при указании несуществующей задачи должен упасть с исключением',
        () {
          final repository = DI.todoRepository;

          //  assert
          expect(
            () => repository.completeTodo(TodoModel.unknown),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });
  });
}
