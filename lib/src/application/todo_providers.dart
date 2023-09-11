import 'package:flutter_architecture/src/data/todo_client.dart';
import 'package:flutter_architecture/src/domain/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todosProvider = FutureProvider.autoDispose<List<Todo>>((ref) => //
    ref.read(todoClientProvider).findAllTodos());
