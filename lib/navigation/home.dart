import 'dart:async';
import 'dart:math';

import 'package:example/models/todos.dart';
import 'package:example/navigation/detailTodos.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.todo}) : super(key: key);
  final List<Todos> todo;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todos> todo = [];

  void _removeTodoItem(int index) {
    setState(() {
      todo.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: ListView.builder(
          itemCount: todo?.length ?? 20,
          itemBuilder: (context, index) {
            return RenderItem(
                todo: todo,
                index: index,
                onRemove: () {
                  _removeTodoItem(index);
                });
          }),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddToForm(
                  onAddTodo: (item) {
                    setState(() {
                      todo.add(item);
                    });
                  },
                  initialTodo: {},
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RenderItem extends StatefulWidget {
  final List<Todos> todo;
  final int index;
  final VoidCallback onRemove; // Callback function to remove item

  const RenderItem(
      {super.key,
      required this.todo,
      required this.index,
      required this.onRemove});

  @override
  State<RenderItem> createState() => _RenderItemState();
}

class _RenderItemState extends State<RenderItem> {
  void _editTodo() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddToForm(
            onAddTodo: (item) {
              setState(() {
                widget.todo[widget.index] = item;
              });
            },
            initialTodo: widget.todo[widget.index],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        child: Text(":"),
                      ),
                      Text(widget.todo[widget.index].title),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        child: Text(":"),
                        width: 10,
                      ),
                      Text(widget.todo[widget.index].description),
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    child: IconButton(
                        onPressed: _editTodo, icon: Icon(Icons.edit)),
                  ),
                  Container(
                    child: IconButton(
                        onPressed: () {
                          widget.onRemove();
                        },
                        icon: Icon(Icons.delete_outline)),
                  ),
                ],
              )),
        ],
      ),
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

class AddToForm extends StatefulWidget {
  final Function(Todos) onAddTodo;
  // ignore: prefer_typing_uninitialized_variables
  final initialTodo;

  const AddToForm(
      {Key? key, required this.onAddTodo, required Object this.initialTodo})
      : super(key: key);

  @override
  _AddToFormState createState() => _AddToFormState();
}

class _AddToFormState extends State<AddToForm> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late Todos initialTodo;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();

    initialTodo = widget.initialTodo is Todos
        ? widget.initialTodo
        : Todos("", ""); // Provide default values if initialTodo is null
    _titleController.text = initialTodo.title;
    _descController.text = initialTodo.description;

    // Check if initialTodo is not null and is an instance of Todos
    if (widget.initialTodo != null && widget.initialTodo is Todos) {
      initialTodo = widget.initialTodo;
      _titleController.text = initialTodo.title;
      _descController.text = initialTodo.description;
    } else {
      initialTodo = Todos("", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    var isEdit = widget.initialTodo != null && widget.initialTodo is Todos;

    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                isEdit ? "Edit Todo" : "Add Todo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Input Title"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _descController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Input Description"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _descController.text.isNotEmpty) {
                    Todos newItem =
                        Todos(_titleController.text, _descController.text);
                    if (initialTodo == null) {
                      widget.onAddTodo(newItem);
                    } else {
                      widget.onAddTodo(newItem);
                    }
                    _titleController.clear();
                    _descController.clear();
                    Navigator.pop(context);
                  } else {
                    validationError(context);
                  }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  void validationError(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error!"),
            content: const Text("Title and description cannot be empty."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Got it!"))
            ],
          );
        });
  }
}
