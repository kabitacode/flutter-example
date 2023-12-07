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

  const RenderItem({super.key, required this.todo, required this.index});

  @override
  State<RenderItem> createState() => _RenderItemState();
}

class _RenderItemState extends State<RenderItem> {
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
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        child: Text(":"),
                        width: 10,
                      ),
                      Container(
                        child: Text(widget.todo[widget.index].title),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        child: Text(":"),
                        width: 10,
                      ),
                      Container(
                        child: Text(widget.todo[widget.index].description),
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ),
                  Container(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.delete_outline)),
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

  const AddToForm({Key? key, required this.onAddTodo}) : super(key: key);

  @override
  _AddToFormState createState() => _AddToFormState();
}

class _AddToFormState extends State<AddToForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Add Todo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Input Title"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: _descController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Input Description"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // Validate and create a new Todos object
                  if (_titleController.text.isNotEmpty &&
                      _descController.text.isNotEmpty) {
                    Todos newItem =
                        Todos(_titleController.text, _descController.text);
                    // Call the callback function to add the newTodo
                    widget.onAddTodo(newItem);

                    //clear textField
                    _titleController.clear();
                    _descController.clear();

                    //Close BottomSheet
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
            title: Text("Error!"),
            content: Text("Title and description cannot be empty."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Got it!"))
            ],
          );
        });
  }
}
