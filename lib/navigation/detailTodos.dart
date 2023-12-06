import 'package:example/models/todos.dart';
import 'package:flutter/material.dart';

class DetailTodos extends StatelessWidget {
  const DetailTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todos;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Pop');
                },
                child: Text("Hello")),
          ),
        ),
      ),
    );
  }
}
