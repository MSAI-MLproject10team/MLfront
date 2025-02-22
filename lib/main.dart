import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Chill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,  // 기본 배경색을 하얀색으로 설정
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          background: Colors.white,  // 배경색 하얀색
          surfaceTint: Colors.transparent,  // 스크롤시 틴트 효과 제거
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,  // 앱바 배경색도 하얀색으로
          elevation: 0,  // 그림자 제거
          scrolledUnderElevation: 0,  // 스크롤시 그림자 효과 제거
        ),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          decoration: TextDecoration.none,  // 전역 텍스트 밑줄 제거
        ),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.grey,
        ),
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildLogo(),
              const SizedBox(height: 40),
              _buildSubTitle(),
              const SizedBox(height: 20),
              _buildDescription(),
              const Spacer(),
              _buildStartButton(context),
              const SizedBox(height: 20),
              _buildLoginLink(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 로고
  Widget _buildLogo() {
    return Text(
      'Personal',
      style: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            blurRadius: 4,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }

  // 서브 타이틀
  Widget _buildSubTitle() {
    return const Text(
      '컬러로 쇼핑하다',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // 설명 텍스트
  Widget _buildDescription() {
    return const Text(
      '퍼스널 컬러에 맞는 중고 패션 & 뷰티템,\n나에게 찰떡 컬러템을 만나보세요!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        height: 1.5,
      ),
    );
  }

  // 시작하기 버튼
  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE3F4FC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: const Text(
          '시작하기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // 로그인 링크
  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '이미 계정이 있으신가요? ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        Material(
          color: const Color(0xFFE3F4FC),
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            splashColor: Colors.blue.withOpacity(0.1),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '로그인',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}