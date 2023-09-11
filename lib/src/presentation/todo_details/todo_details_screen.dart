import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/application/todo_providers.dart';
import 'package:flutter_architecture/src/domain/todo.dart';
import 'package:flutter_architecture/src/widgets/async_value_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoDetailsScreen extends ConsumerWidget {
  const TodoDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodo = ref.watch(todoProvider(id, 0));

    return Center(
      child: AsyncValueWidget<Todo>(
        value: asyncTodo,
        data: (todo) => Text(todo.name),
      ),
    );
  }
}
