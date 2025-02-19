import 'package:flutter/material.dart';

class ProfileChangeScreen extends StatefulWidget {
  const ProfileChangeScreen({super.key});

  @override
  State<ProfileChangeScreen> createState() => _ProfileChangeScreenState();
}

class _ProfileChangeScreenState extends State<ProfileChangeScreen> {
  // 개인정보 상태 관리
  String name = '홍길동';
  String birthDate = '1990-01-01';
  String phoneNumber = '010-1234-5678';
  String personalColor = '# 여름_라이트';
  bool isEditing = false;  // 수정 모드 상태

  // 텍스트 컨트롤러들
  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: name);
    birthController = TextEditingController(text: birthDate);
    phoneController = TextEditingController(text: phoneNumber);
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      if (isEditing) {
        // 저장 로직
        name = nameController.text;
        birthDate = birthController.text;
        phoneNumber = phoneController.text;
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      '내정보',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24), // 균형을 위한 여백
                ],
              ),
            ),
            // 프로필 이미지 섹션
            Container(
              height: 140,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  // 프로필 이미지
                  Center(
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 70, color: Colors.white),
                    ),
                  ),
                  // 수정 버튼
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TextButton(
                      onPressed: toggleEdit,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(60, 30),
                      ),
                      child: Text(
                        isEditing ? '저장' : '수정',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // 카메라 아이콘
                  if (isEditing)
                    Positioned(
                      bottom: 0,
                      right: 180,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD6EAF8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 20),
                      ),
                    ),
                ],
              ),
            ),
            // 정보 리스트와 버튼들
            Expanded(
              child: Column(  // ListView를 Column으로 변경
                children: [
                  Expanded(  // 정보 리스트를 Expanded로 감싸기
                    child: ListView(
                      children: [
                        _buildInfoItem('이름', nameController, enabled: isEditing),
                        _buildInfoItem('생년월일', birthController, enabled: isEditing),
                        _buildInfoItem('전화번호', phoneController, enabled: isEditing),
                        _buildPersonalColorItem(isEditing),
                        const SizedBox(height: 40),
                        // 회원탈퇴 버튼
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: 회원탈퇴 로직
                              },
                              child: const Text(
                                '회원탈퇴',
                                style: TextStyle(
                                  color: Color(0xFFF86565),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 로그아웃 버튼
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFE5E8EB)),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // TODO: 로그아웃 로직
                      },
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, TextEditingController controller, {bool enabled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E8EB), width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF3A4954),
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalColorItem(bool enabled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E8EB), width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              '퍼스널 컬러',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          if (enabled)
            TextButton(
              onPressed: () {
                // TODO: 퍼스널 컬러 선택 다이얼로그
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFC2EBFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  personalColor,
                  style: const TextStyle(
                    color: Color(0xFF84CAEC),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFC2EBFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                personalColor,
                style: const TextStyle(
                  color: Color(0xFF84CAEC),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


