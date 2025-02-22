import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

import '../widgets/custom_bottom_navigation.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  bool autoLogin = false;
  int _selectedIndex = 0;
 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  // 배경 투명하게
        elevation: 0,  // 그림자 제거
        leading: IconButton(  // 뒤로가기 버튼
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 0),
            // Personal (홈 화면 스타일과 동일하게 수정)
            Center(
              child: Text(
                'Personal',
                style: TextStyle(
                  fontSize: 64,  // 홈 화면과 동일한 크기
                  fontWeight: FontWeight.w600,  // 홈 화면과 동일한 폰트 굵기
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 2,
              color: const Color(0xFF86CCFC),
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),
            const SizedBox(height: 30),
 
            // 아이디 입력
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTextField(
                icon: Icons.person,
                hintText: '아이디 입력',
                controller: _idController,
              ),
            ),
            const SizedBox(height: 15),
 
            // 비밀번호 입력
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTextField(
                icon: Icons.lock,
                hintText: '비밀번호 입력',
                controller: _pwController,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 25),
 
            // 로그인 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD2E7FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // 로그인 성공 시 HomeScreen으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: const Text(
                    '로그인',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
 
            // 자동로그인 옵션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Checkbox(
                    value: autoLogin,
                    onChanged: (val) {
                      setState(() {
                        autoLogin = val ?? false;
                      });
                    },
                  ),
                  const Text('자동로그인', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: 아이디 찾기
                    },
                    child: const Text(
                      '아이디 찾기',
                      style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      // TODO: 비밀번호 찾기
                    },
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: Color(0xFFC8C8C8), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
 
            // 회원가입 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF86CCFC), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 20, color: Color(0xFF86CCFC)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
 
  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC8C8C8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, size: 30, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFFC8C8C8)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
