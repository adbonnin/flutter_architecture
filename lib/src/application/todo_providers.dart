import 'package:flutter_architecture/src/data/todo_client.dart';
import 'package:flutter_architecture/src/domain/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_providers.g.dart';

@Riverpod()
Future<List<Todo>> filterTodos(FilterTodosRef ref) async {
  final todos = await ref.watch(todosProvider.future);
  return todos.where((element) => element.id % 2 == 0).toList();
}

@Riverpod()
Future<List<Todo>> todos(TodosRef ref) {
  return ref.read(todoClientProvider).findAllTodos();
}

@Riverpod()
Future<Todo> todo(TodoRef ref, int id, int id2) {
  return ref.read(todoClientProvider).findById(id);
}
