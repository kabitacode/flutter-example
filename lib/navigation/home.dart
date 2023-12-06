import 'package:example/models/todos.dart';
import 'package:example/navigation/detailTodos.dart';
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
          itemCount: todo?.length ?? 20,
          itemBuilder: (context, index) {
            return RenderItem(todo: todo, index: index);
          }),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class RenderItem extends StatefulWidget {
  final List<Todos> todo;
  final int index;

  const RenderItem({super.key, required this.todo, required this.index});

  @override
  State<RenderItem> createState() => _RenderItemState();
}

class _RenderItemState extends State<RenderItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.todo[widget.index].title),
      subtitle: Text(widget.todo[widget.index].description),
      onTap: () {
        _navigateAndDisplaySelection(context);
      },
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DetailTodos(),
            settings: RouteSettings(arguments: widget.todo[widget.index])));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.

    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));

    print(result);
  }
}
