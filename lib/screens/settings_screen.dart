import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'settings/my_posts_screen.dart';
import 'settings/sales_history_screen.dart';
import 'settings/purchase_history_screen.dart';
import 'settings/app_settings_screen.dart';
import 'settings/customer_service_screen.dart';
import 'settings/profile_change_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 하늘색 줄 위치 이동
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),  // top 패딩 추가
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF87CCFD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // 프로필 카드
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkResponse(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProfileChangeScreen()),
                                );
                              },
                              
                              containedInkWell: true,
                              highlightShape: BoxShape.rectangle,
                              highlightColor: Colors.grey.withOpacity(0.1),
                              splashColor: Colors.grey.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person, size: 35, color: Colors.white),
                                    ),
                                    const SizedBox(width: 16),
                                    const Text(
                                      '홍길동',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 메뉴 리스트
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem('내 게시물', onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyPostsScreen()),
                                );
                              }),
                              _buildMenuItem('판매내역', onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SalesHistoryScreen()),
                                );
                              }),
                              _buildMenuItem('구매내역', onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PurchaseHistoryScreen()),
                                );
                              }),
                              _buildMenuItem('앱 설정', onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AppSettingsScreen()),
                                );
                              }),
                              _buildMenuItem('고객센터', onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CustomerServiceScreen()),
                                );
                              }, isLast: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {required VoidCallback onTap, bool isLast = false}) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkResponse(
            onTap: onTap,
            containedInkWell: true,
            highlightShape: BoxShape.rectangle,
            highlightColor: Colors.grey.withOpacity(0.1),
            splashColor: Colors.grey.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0x7F9BAABA),
          ),
      ],
    );
  }
} 