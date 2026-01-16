import 'package:flutter/material.dart';

class TodoListBottom extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TodoListBottom({
    super.key, // (옵션) 위젯 식별용 키
    required this.currentIndex, // (필수) 현재 선택된 인덱스, 반드시 값이 있어야 함
    required this.onTap, // (필수) 탭 클릭 시 실행할 함수, 반드시 값이 있어야 함
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items:
          [
                {'icon': Icons.home, 'label': 'Home'},
                {'icon': Icons.list, 'label': 'List'},
                {'icon': Icons.settings, 'label': 'Settings'},
              ]
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item['icon'] as IconData),
                  label: item['label'] as String,
                ),
              )
              .toList(),
    );
  }
}
