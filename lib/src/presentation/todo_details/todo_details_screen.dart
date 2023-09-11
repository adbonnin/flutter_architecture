import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Todo $id"),
    );
  }
}
