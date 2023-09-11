import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/application/todo_providers.dart';
import 'package:flutter_architecture/src/domain/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  // var _todos = <Todo>[];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(), _updateTodos);
  // }
  //
  // Future<void> _updateTodos() async {
  //   final todoClient = ref.read(todoClientProvider);
  //   final todos = await todoClient.findAllTodos();
  //
  //   setState(() {
  //     _todos = todos;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final asyncTodos = ref.watch(filterTodosProvider);

    return Center(
      child: asyncTodos.when(
        skipLoadingOnRefresh: false,
        data: (todos) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _onRefreshPressed,
              child: Text("refresh"),
            ),
            for (final todo in todos) //
              TodoCard(todo: todo)
          ],
        ),
        error: (e, s) => Text(e.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }

  void _onRefreshPressed() {
    ref.invalidate(todosProvider);
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkResponse(
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(todo.name),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    context.go('/todos/${todo.id}');
  }
}
