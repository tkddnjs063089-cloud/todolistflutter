import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String text;
  final bool isDone;
  final Function(String) onSaved;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.text,
    required this.isDone,
    required this.onSaved,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _editController;
  bool _isEditing = false; // 이 값이 true일 때만 입력창으로 변함

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    if (_isEditing) {
      widget.onSaved(_editController.text); // 변경사항 부모에게 전달
    }
    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          widget.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: widget.isDone ? Colors.green : null,
        ),
        onPressed: widget.onToggle,
      ),
      title: _isEditing
          ? TextField(
              controller: _editController,
              autofocus: true,
              onSubmitted: (_) => _toggleEdit(),
            )
          : Text(
              widget.text,
              style: TextStyle(
                decoration: widget.isDone ? TextDecoration.lineThrough : null,
                color: widget.isDone ? Colors.grey : null,
              ),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _toggleEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}
