import 'package:flutter/material.dart';
import '../colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // 더미 데이터를 const로 선언
  static const List<NotificationItem> _dummyNotifications = [
    NotificationItem(
      icon: Icons.favorite,
      message: '회원님의 게시물을 좋아합니다.',
      time: '방금 전',
    ),
    NotificationItem(
      icon: Icons.comment,
      message: '회원님의 게시물에 댓글을 남겼습니다.',
      time: '10분 전',
    ),
    NotificationItem(
      icon: Icons.person_add,
      message: '회원님을 팔로우하기 시작했습니다.',
      time: '1시간 전',
    ),
    NotificationItem(
      icon: Icons.shopping_bag,
      message: '새로운 상품이 등록되었습니다.',
      time: '2시간 전',
    ),
    NotificationItem(
      icon: Icons.local_offer,
      message: '회원님이 관심있어할 만한 상품이 있습니다.',
      time: '3시간 전',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '알림',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _dummyNotifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Colors.grey.shade200,
        ),
        itemBuilder: (context, index) {
          final notification = _dummyNotifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Icon(
                notification.icon,
                color: Colors.black,
                size: 20,
              ),
            ),
            title: Text(
              notification.message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              notification.time,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            onTap: () {
              // 알림 클릭 시 처리
            },
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String message;
  final String time;

  // 생성자를 const로 선언
  const NotificationItem({
    required this.icon,
    required this.message,
    required this.time,
  });
} 