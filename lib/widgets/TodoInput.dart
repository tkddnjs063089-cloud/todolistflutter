import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const TodoInput({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '새 작업을 입력하세요'),
          onSubmitted: (_) => onSubmitted(),
        ),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            onPressed: onSubmitted,
            child: const Text('할 일 추가'),
          ),
        ),
      ],
    );
  }
}
