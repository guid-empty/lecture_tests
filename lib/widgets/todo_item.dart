import 'package:flutter/material.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';

typedef CheckBoxTapCallback = void Function(TodoModel);

class TodoItemWidget extends StatelessWidget {
  final TodoModel item;
  final bool selected;
  final CheckBoxTapCallback onCheckBoxTap;

  const TodoItemWidget({
    required this.item,
    required this.selected,
    required this.onCheckBoxTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      selected: selected,
      selectedTileColor: item.isCompleted
          ? theme.primaryColor.withOpacity(0.5)
          : theme.primaryColor,
      selectedColor: theme.scaffoldBackgroundColor,
      tileColor: item.isCompleted ? theme.disabledColor : null,
      // leading: Icon(
      //   item.isCompleted ? Icons.done : Icons.access_time,
      //   color: selected
      //       ? Colors.white
      //       : item.isCompleted
      //           ? null
      //           : theme.primaryColor,
      //   size: 20,
      // ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              item.title,
              style: item.isCompleted
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
          ),
          GestureDetector(
            onTap: () => onCheckBoxTap(item),
            child: Icon(
              item.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              key: ValueKey('item_icon_${item.id}'),
            ),
          )
        ],
      ),
    );
  }
}
