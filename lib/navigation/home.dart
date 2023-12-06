import 'package:example/models/todos.dart';
import 'package:example/navigation/detailTodos.dart';
import 'package:example/navigation/secondRoute.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.todo}) : super(key: key);

  final List<Todos> todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todo[index + 1].title),
                subtitle: Text(todo[index + 1].description),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailTodos(),
                          settings: RouteSettings(arguments: todo[index])))
                },
              );
            }));
  }
}
