import 'package:flutter/material.dart';
import 'package:todolist/widgets/TodoInput.dart';
import 'package:todolist/widgets/TodoListHome.dart';
import 'package:todolist/widgets/TodoItem.dart';
import 'package:todolist/widgets/TodoListCalendar.dart';

class TodoListBody extends StatelessWidget {
  final TextEditingController mainController;
  final List<Todo> todos;
  final VoidCallback addNewTodo;
  final Function(int, String) onUpdateTodo;
  final Function(int) onToggleTodo;
  final Function(int) onDeleteTodo;

  const TodoListBody({
    super.key,
    required this.mainController,
    required this.todos,
    required this.addNewTodo,
    required this.onUpdateTodo,
    required this.onToggleTodo,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoInput(controller: mainController, onSubmitted: addNewTodo),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItem(
                key: ValueKey(todos[index].title + index.toString()),
                text: todos[index].title,
                isDone: todos[index].isDone,
                onSaved: (newValue) {
                  onUpdateTodo(index, newValue);
                },
                onToggle: () {
                  onToggleTodo(index);
                },
                onDelete: () {
                  onDeleteTodo(index);
                },
              );
            },
          ),
        ),

        StatefulBuilder(
          builder: (context, setState) {
            bool isCalendarVisible = false;

            // workaround for StatefulBuilder not keeping state; use a ValueNotifier
            final ValueNotifier<bool> notifier = ValueNotifier(false);

            return Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: notifier,
                  builder: (context, value, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => notifier.value = true,
                        ),
                      ],
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: notifier,
                  builder: (context, visible, _) {
                    if (!visible) return SizedBox.shrink();
                    return Column(
                      children: [
                        TodoListCalendar(),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () => notifier.value = false,
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
