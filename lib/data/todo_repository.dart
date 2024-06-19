import 'package:collection/collection.dart';
import 'package:lecture_about_tests/domain/todo.dart';

class TodoRepository {
  /// InMemory хранилище данных
  Set<Todo> _todos = {
    const Todo(id: 2, title: 'Task 2', isCompleted: false),
    const Todo(id: 4, title: 'Task 4', isCompleted: false),
    const Todo(id: 3, title: 'Task 3', isCompleted: false),
    const Todo(id: 1, title: 'Task 1', isCompleted: false),
    const Todo(id: 5, title: 'Task 5', isCompleted: false),
  };

  /// Получить из хранилища все задачи
  Iterable<Todo> fetchAll() => _todos.sorted((a, b) => a.id.compareTo(b.id));

  /// Создать новую задачу
  Todo create({bool isCompleted = false}) {
    final sortedTodos = fetchAll();
    final id = sortedTodos.last.id + 1;

    final todo = Todo(id: id, title: 'Task $id', isCompleted: isCompleted);
    _todos.add(todo);

    return todo;
  }

  /// Удалить задачу по ее Id
  void removeById(int id) {
    _guard(id);
    _todos = _todos.where((e) => e.id != id).toSet();
  }

  /// Завершить задачу
  void completeTodo(Todo todo) {
    _guard(todo.id);
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: true) : e)
        .toSet();
  }

  /// Восстановить задачу в незавершенное состояние
  void unCompleteTodo(Todo todo) {
    _guard(todo.id);
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: false) : e)
        .toSet();
  }

  /// Обновить задачу
  void update({
    required int id,
    required String title,
    bool? isCompleted,
  }) {
    _guard(id);
    _todos = _todos
        .map((e) => e.id == id
            ? e.copyWith(
                title: title,
                isCompleted: isCompleted ?? e.isCompleted,
              )
            : e)
        .toSet();
  }

  /// Проверяет наличие задачи в хранилище
  void _guard(int id) {
    if (_todos.none((e) => e.id == id)) {
      throw NotFoundException('There are no todo with id = $id!');
    }
  }
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException{message: $message}';
}
