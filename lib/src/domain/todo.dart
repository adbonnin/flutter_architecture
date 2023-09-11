import 'package:flutter_architecture/src/domain/label.dart';
import 'package:flutter_architecture/src/utils/json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  const Todo({
    required this.id,
    required this.name,
    this.labels = const [],
  });

  final int id;
  final String name;
  final List<Label> labels;

  factory Todo.fromJson(Map<String, dynamic> json) => //
      _$TodoFromJson(json);

  static List<Todo> fromJsonList(Object? json) => //
      Json.fromList(json, Todo.fromJson);

  Map<String, dynamic> toJson() => //
      _$TodoToJson(this);
}
