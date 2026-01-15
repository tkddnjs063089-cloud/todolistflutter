import 'package:flutter/material.dart';
import 'package:todolist/widgets/TodoListHome.dart';

class TodoListHomeState extends State<TodoListHome> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _todos = [];
  int _bottomNavIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodo() {
    String text = _controller.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('내용을 입력해야 합니다!', style: TextStyle(color: Colors.black)),
          backgroundColor: Color.fromARGB(255, 251, 210, 255),
          duration: Duration(seconds: 2), // 2초 동안 보여줌
        ),
      );
      return; // 함수 종료
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '여기에 새 작업을 입력하세요',
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => _addTodo(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _addTodo, child: Text('할 일 추가')),
            const SizedBox(height: 24),
            Expanded(
              child: _todos.isEmpty
                  ? Center(child: Text('할 일이 없습니다.'))
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(_todos[index]));
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
