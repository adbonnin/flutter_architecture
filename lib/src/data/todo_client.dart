import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_architecture/src/application/auth_providers.dart';
import 'package:flutter_architecture/src/domain/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoClientProvider = Provider<TodoClient>((ref) => //
    TodoClient(ref));

final httpClientProvider = Provider<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://myfakeapi.com/api',
      ),
    );

    dio.interceptors.add(AuthInterceptor(ref));
    return dio;
  },
);

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);

  final Ref ref;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final response = await ref.read(authProvider.future);
    final token = response.token;

    if (token != '') {
      options.headers = {
        ...options.headers,
        'token': token,
      };
    }

    handler.next(options);
  }
}

class TodoClient {
  TodoClient(this.ref);

  final Ref ref;

  Future<List<Todo>> findAllTodos() async {
    // final httpClient = ref.read(httpClientProvider);
    // httpClient.get('https://myfakeapi.com/api/cars/');

    print('find all todos');

    final response = jsonDecode('''
      [
        {
          "id": 1,
          "name": "Test"
        }
      ]
    ''');

    final todos = Todo.fromJsonList(response);
    return Future.delayed(Duration(seconds: 3), () => todos);
  }

  Future<Todo> findById(int id) async {

    print('find by id');

    final response = jsonDecode('''

        {
          "id": $id,
          "name": "Test $id"
        }
      
    ''');

    final todo = Todo.fromJson(response);
    return Future.delayed(Duration(seconds: 3), () => todo);
  }
}

class PotatoesClient {
  PotatoesClient(this.ref);

  final Ref ref;
}
