import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            
            // 뒤로가기 버튼과 로고를 포함한 Row
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 우측 여백을 위한 빈 공간
                const SizedBox(width: 48),  // IconButton의 너비만큼
              ],
            ),

            const SizedBox(height: 12),
            Container(
              height: 2.5,
              color: const Color(0xFF86CCFC),
              margin: const EdgeInsets.symmetric(horizontal: 5),
            ),
            const SizedBox(height: 30),

            // 입력 필드들
            _buildLabel('아이디'),
            _buildField(_idController, '아이디 입력'),
            const SizedBox(height: 20),

            _buildLabel('비밀번호'),
            _buildField(_pwController, '비밀번호 입력', obscureText: true),
            const SizedBox(height: 20),

            _buildLabel('비밀번호 확인'),
            _buildField(_pwConfirmController, '비밀번호 확인 입력', obscureText: true),
            const SizedBox(height: 20),

            _buildLabel('이름'),
            _buildField(_nameController, '이름 입력'),
            const SizedBox(height: 20),

            _buildLabel('전화번호'),
            _buildField(_phoneController, '전화번호 입력'),
            const SizedBox(height: 20),

            _buildLabel('생년월일'),
            Row(
              children: [
                Expanded(child: _buildField(_yearController, '년')),
                const SizedBox(width: 5),
                Expanded(child: _buildField(_monthController, '월')),
                const SizedBox(width: 5),
                Expanded(child: _buildField(_dayController, '일')),
              ],
            ),
            const SizedBox(height: 40),

            // ✅ 회원가입 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD2E7FC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // 회원가입 성공 시 HomeScreen으로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 라벨을 추가하는 메서드
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 입력 필드 위젯
  Widget _buildField(TextEditingController controller, String hint, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC8C8C8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFC8C8C8)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
