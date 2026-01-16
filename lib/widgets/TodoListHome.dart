import 'package:flutter/material.dart';
import 'package:todolist/widgets/TodoListBottom.dart';
import 'package:todolist/widgets/TodoListBody.dart';

class Todo {
  String title;
  bool isDone;
  DateTime date;
  List<String> subTasks;

  Todo({
    required this.title,
    this.isDone = false,
    required this.date,
    this.subTasks = const [],
  });
}

class TodoListHome extends StatefulWidget {
  const TodoListHome({super.key});

  @override
  State<TodoListHome> createState() => TodoListHomeState();
}

class TodoListHomeState extends State<TodoListHome> {
  final TextEditingController _mainController = TextEditingController();
  final List<Todo> _todos = [];
  int _bottomNavIndex = 0;

  // 신규 추가 로직
  void _addNewTodo() {
    String text = _mainController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(title: text, date: DateTime.now()));
        _mainController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TodoListBody(
          mainController: _mainController,
          todos: _todos,
          addNewTodo: _addNewTodo,
          onUpdateTodo: (index, newValue) {
            setState(() => _todos[index].title = newValue);
          },
          onToggleTodo: (index) {
            setState(() => _todos[index].isDone = !_todos[index].isDone);
          },
          onDeleteTodo: (index) {
            setState(() => _todos.removeAt(index));
          },
        ),
      ),
      bottomNavigationBar: TodoListBottom(
        currentIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
