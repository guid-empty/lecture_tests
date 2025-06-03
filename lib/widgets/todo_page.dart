import 'package:flutter/material.dart';
import 'package:lecture_about_tests/data/todo_repository.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  final String title;
  final TodoRepository todoRepository;

  const TodoPage({
    required this.todoRepository,
    required this.title,
    super.key,
  });

  @override
  State<TodoPage> createState() => TodoPageState();
}

@visibleForTesting
class TodoPageState extends State<TodoPage> {
  List<TodoModel> todos = [];
  ScrollController scrollController = ScrollController();
  TodoModel? selectedTodo;

  @override
  void initState() {
    super.initState();
    todos = widget.todoRepository.fetchAll().toList();
    selectedTodo = todos.lastOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        key: const Key('long_list'),
        controller: scrollController,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return GestureDetector(
            onTap: () => setState(() => selectedTodo = todo),
            child: TodoItemWidget(
              key: ValueKey('item_${todo.id}'),
              item: todo,
              selected: _isSelected(todo),
              onCheckBoxTap: _handleCheckBoxTap,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('todo_creation'),
        onPressed: _createTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _createTask() {
    setState(() {
      selectedTodo = DI.todoRepository.create();
      todos = DI.todoRepository.fetchAll().toList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });
    });
  }

  void _handleCheckBoxTap(TodoModel todo) {
    if (todo.isCompleted) {
      DI.todoRepository.unCompleteTodo(todo);
    } else {
      DI.todoRepository.completeTodo(todo);
    }

    setState(() {
      todos = DI.todoRepository.fetchAll().toList();
      selectedTodo = todo;
    });
  }

  bool _isSelected(TodoModel todo) => selectedTodo?.id == todo.id;
}
