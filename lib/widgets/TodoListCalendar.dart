import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoListCalendar extends StatefulWidget {
  const TodoListCalendar({super.key});
  @override
  State<TodoListCalendar> createState() => _TodoListCalendarState();
}

class _TodoListCalendarState extends State<TodoListCalendar> {
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2025, 1, 1),
      lastDay: DateTime.utc(2125, 12, 31),
      focusedDay: _selectedDay,
      onDaySelected: (DateTime day, DateTime focusedDay) {
        setState(() => _selectedDay = day);
      },
    );
  }
}
