import 'package:flutter/material.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고객센터'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('자주 묻는 질문'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: FAQ 페이지로 이동
            },
          ),
          ListTile(
            title: const Text('1:1 문의하기'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 문의하기 페이지로 이동
            },
          ),
          const ListTile(
            title: Text('고객센터'),
            subtitle: Text('평일 09:00-18:00'),
            trailing: Text('1234-5678'),
          ),
        ],
      ),
    );
  }
} 