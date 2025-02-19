import 'package:flutter/material.dart';

class MyPersonalScreen extends StatelessWidget {
  const MyPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 48,
            color: Colors.blue[300],
          ),
          const SizedBox(height: 16), 
          const Text(
            '내 퍼스널',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 