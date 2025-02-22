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
    return SizedBox(
      height: 70,
      child: IgnorePointer(
        ignoring: false,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Theme(
            data: Theme.of(context).copyWith(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedIconTheme: const IconThemeData(size: 24),
                unselectedIconTheme: const IconThemeData(size: 24),
                selectedLabelStyle: const TextStyle(fontSize: 12, height: 0),
                unselectedLabelStyle: const TextStyle(fontSize: 12, height: 0),
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Transform.translate(
              offset: const Offset(0, -5),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                iconSize: 25,
                enableFeedback: false,
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: '홈',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.search_outlined),
                    activeIcon: Icon(Icons.search),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Transform.translate(
                      offset: const Offset(0,4),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedIndex == 2
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
                            const SizedBox(height: 2),
                            Text(
                              '게시물 등록',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: selectedIndex == 2 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    activeIcon: Icon(Icons.favorite),
                    label: '찜',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: '마이',
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                onTap: onTap,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 