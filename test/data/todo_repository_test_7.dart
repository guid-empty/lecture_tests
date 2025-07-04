import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/data/todo_repository_refactored.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late TodoApiMock todoApiMock;
  late TodoRepository repository;

  setUp(() {
    todoApiMock = TodoApiMock();
    when(
      () => todoApiMock.saveTodo(any(), any()),
    ).thenAnswer((_) async => TodoModel.unknown);

    when(() => todoApiMock.saveTodo('some title', false)).thenAnswer(
      (_) async => TodoModel(id: -1, title: 'some title', isCompleted: false),
    );

    when(
      () => todoApiMock.saveTodo(
        any(that: isA<String>()),
        any(that: isA<bool>()),
      ),
    ).thenAnswer((_) async => TodoModel.unknown);

    repository = TodoRepository(todoApi: todoApiMock);
  });

  group('TodoRepository', () {
    test(
      'и его метод create должен выполнить обращение к TodoApi с правильными аргументами',
      () async {
        //  arrange
        const expectedTitle = 'Новая задача';
        const expectedIsCompleted = true;

        //  act
        await repository.create(
          title: expectedTitle,
          isCompleted: expectedIsCompleted,
        );

        //  assert
        final verification = verify(
          () => todoApiMock.saveTodo(captureAny(), captureAny()),
        );
        expect(verification.callCount, 1);

        final capturedArguments = verification.captured;
        expect(capturedArguments.first, expectedTitle);
        expect(capturedArguments.last, expectedIsCompleted);
      },
    );
  });
}

class TodoApiMock extends Mock implements TodoApi {}
