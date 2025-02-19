import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 설정'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('알림 설정'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TODO: 알림 설정 변경 로직
              },
            ),
          ),
          const ListTile(
            title: Text('앱 버전'),
            trailing: Text('1.0.0'),
          ),
          // 추가 설정 항목들...
        ],
      ),
    );
  }
} 