import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: onTap,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 28,
          selectedLabelStyle: const TextStyle(height: 1.5),
          unselectedLabelStyle: const TextStyle(height: 1.5),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home_outlined),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.favorite_outline),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.favorite),
              ),
              label: '찜 목록',
            ),
            BottomNavigationBarItem(
              icon: Transform.translate(
                offset: const Offset(0, 0),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedIndex == 2 // 선택 시 색상 변경
                        ? const Color(0xFFCCEBF9)  
                        : const Color(0xFFE3F4FC),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.1,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        selectedIndex == 2 ? Icons.edit : Icons.edit_outlined,
                        color: selectedIndex == 2 ? Colors.black : Colors.grey,
                        size: 25,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '게시물 등록',
                        style: TextStyle(
                          fontSize: 11,
                          color: selectedIndex == 2 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.palette_outlined),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.palette),
              ),
              label: '내 퍼스널',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.settings_outlined),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.settings),
              ),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
} 