import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageList extends StatelessWidget {
  final list = [
    {'name': '过滤列表', 'route': '/filterList'},
  ];

  PageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('示例列表')),
      body: ListView(
        children: list
            .map(
              (e) => ListTile(
                title: Text(
                  e['name']!,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                onTap: () => context.go(e['route']!),
              ),
            )
            .toList(),
      ),
    );
  }
}
