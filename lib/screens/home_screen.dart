import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'favorite_screen.dart';
import 'post_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeMainScreen(),
      const FavoriteScreen(),
      const PostScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: _pages[selectedNavIndex],
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: selectedNavIndex,
        onTap: (index) {
          setState(() {
            selectedNavIndex = index;
          });
        },
      ),
    );
  }
}

// HomeMainScreen 위젯 추가
class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  String selectedSeason = '봄';
  String selectedCategory = '브라이트';
  String selectedClothingType = '상의';
  Map<String, bool> favoriteStates = {};

  final Map<String, List<String>> seasonCategories = {
    '봄': ['라이트', '브라이트', '웜'],
    '여름': ['라이트', '뮤트', '쿨'],
    '가을': ['뮤트', '딥', '웜'],
    '겨울': ['브라이트', '딥', '쿨'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFixedCategoryRow(),
        _buildSeasonRow(),
        _buildDynamicCategoryRow(),
        Expanded(
          child: ListView(
            children: [
              _buildProductCard(),
              _buildProductCard(),
            ],
          ),
        ),
      ],
    );
  }

  // 의류 카테고리 행
  Widget _buildFixedCategoryRow() {
    final categories = [
      {'label': '아우터', 'image': 'assets/images/outer.png'},
      {'label': '상의', 'image': 'assets/images/top.png'},
      {'label': '바지', 'image': 'assets/images/pants.png'},
      {'label': '치마/원피스', 'image': 'assets/images/dress.png'},
    ];
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                children: categories.map((category) {
                  final isSelected = category['label'] == selectedClothingType;
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            selectedClothingType = category['label']!;
                          });
                        },
                        child: Container(
                          width: 85,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? Colors.black : Colors.grey.shade300,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(category['image']!, width: 50, height: 50),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  category['label']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected ? Colors.black : Colors.grey[600],
                                    fontSize: category['label'] == '치마/원피스' ? 13.5 : 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }

  // 계절 카테고리 행
  Widget _buildSeasonRow() {
    final seasons = ['봄', '여름', '가을', '겨울'];
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
      ),
      child: Row(
        children: seasons.map((season) {
          final isSelected = season == selectedSeason;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSeason = season;
                  selectedCategory = seasonCategories[season]![0];
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isSelected
                      ? const Border(
                          bottom: BorderSide(color: Colors.black, width: 2),
                        )
                      : null,
                ),
                child: Text(
                  season,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 컬러 카테고리 행
  Widget _buildDynamicCategoryRow() {
    final categories = seasonCategories[selectedSeason]!;
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
      ),
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Center(
                child: Text(
                  category.replaceAll(RegExp(r'^(봄|여름|가을|겨울)\s*'), ''),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 상품 카드
  Widget _buildProductCard() {
    String productId = "1";
    bool isFavorite = favoriteStates[productId] ?? false;

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi45eeKQ_tpZ7VHGhw4jAXC7NsF_0TjkgT3g&s",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '안입는 푸른색 상의',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '# 봄_브라이트',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '5,000원',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  favoriteStates[productId] = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}