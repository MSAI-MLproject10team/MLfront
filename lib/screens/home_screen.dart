import 'package:flutter/material.dart';
import '../models/post_response.dart';
import '../colors.dart';
import '../models/dummy_api_response.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'settings/my_posts_screen.dart';
import 'product_detail_screen.dart';
import 'favorite_screen.dart';
import 'post_screen.dart';
import 'my_personal_screen.dart';
import 'settings_screen.dart';
import '../widgets/product_card.dart';
import '../models/color_pair.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? selectedSeason;
  String? selectedCategory;
  String selectedClothingType = '아우터';
  List<String> selectedTags = [];
  Map<String, bool> favoriteStates = {};

  final Map<String, List<String>> seasonCategories = {
    '봄': ['라이트', '브라이트', '트루'],
    '여름': ['라이트', '뮤트', '트루'],
    '가을': ['뮤트', '딥', '트루'],
    '겨울': ['브라이트', '딥', '트루'],
  };

  // colorMap 추가
  final Map<String, ColorPair> colorMap = {
    '봄_라이트': ColorPair(const Color(0xFFFFF4C2), const Color(0xFFFBD931)),
    '봄_트루': ColorPair(const Color(0xFFFFD9AC), const Color(0xFFFDA844)),
    '봄_브라이트': ColorPair(const Color(0xFFFFC5C5), const Color(0xFFF06260)),
    '여름_라이트': ColorPair(const Color(0xFFC2EBFF), const Color(0xFF84CAEC)),
    '여름_트루': ColorPair(const Color(0xFF9BCFFB), const Color(0xFF346EA0)),
    '여름_뮤트': ColorPair(const Color(0xFFC2B4E2), const Color(0xFF8977B5)),
    '가을_뮤트': ColorPair(const Color(0xFFB3C397), const Color(0xFF86956D)),
    '가을_트루': ColorPair(const Color(0xFFDBBD9B), const Color(0xFFB4926D)),
    '가을_딥': ColorPair(const Color(0xFFA8878F), const Color(0xFF442129)),
    '겨울_브라이트': ColorPair(const Color(0xFF89F6E6), const Color(0xFF1FA793)),
    '겨울_트루': ColorPair(const Color(0xFF302221), Colors.white),
    '겨울_딥': ColorPair(const Color(0xFF519AA9), const Color(0xFF17383F)),
  };

  // toggleFavorite 함수 추가
  void toggleFavorite(String postId) {
    setState(() {
      final posts = dummyPostApiResponse['data']['posts'] as List<dynamic>;
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        posts[postIndex]['isFavorite'] = !posts[postIndex]['isFavorite'];
      }
    });
  }

  // 페이지 리스트 추가
  final List<Widget> _pages = [
    const HomePageContent(),  // 홈 화면 컨텐츠
    const FavoriteScreen(),   // 찜 화면
    const PostScreen(),       // 게시물 등록 화면
    const MyPersonalScreen(), // 내 퍼스널 화면
    const SettingsScreen(),   // 설정 화면
  ];

  // 계절별 색상 매핑
  Color getSeasonalColor(String? season, String? category) {
    if (season == null || category == null) return Colors.black;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightFont;
      if (category == '브라이트') return AppColors.springBrightFont;
      if (category == '트루') return AppColors.springTrueFont;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightFont;
      if (category == '뮤트') return AppColors.summerMuteFont;
      if (category == '트루') return AppColors.summerTrueFont;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepFont;
      if (category == '뮤트') return AppColors.autumnMuteFont;
      if (category == '트루') return AppColors.autumnTrueFont;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepFont;
      if (category == '브라이트') return AppColors.winterBrightFont;
      if (category == '트루') return AppColors.winterTrueFont;
    }
    return Colors.black;
  }

  // 계절별 배경색 매핑
  Color getSeasonalBgColor(String? season, String? category) {
    if (season == null || category == null) return Colors.grey.shade200;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightBg;
      if (category == '브라이트') return AppColors.springBrightBg;
      if (category == '트루') return AppColors.springTrueBg;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightBg;
      if (category == '뮤트') return AppColors.summerMuteBg;
      if (category == '트루') return AppColors.summerTrueBg;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepBg;
      if (category == '뮤트') return AppColors.autumnMuteBg;
      if (category == '트루') return AppColors.autumnTrueBg;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepBg;
      if (category == '브라이트') return AppColors.winterBrightBg;
      if (category == '트루') return AppColors.winterTrueBg;
    }
    return Colors.grey.shade200;
  }

  // 계절 선택 시
  void selectSeason(String season) {
    setState(() {
      if (selectedSeason == season) {
        selectedSeason = null;
      } else {
        selectedSeason = season;
      }
    });
  }

  // 카테고리 선택 시
  void selectCategory(String category) {
    setState(() {
      if (selectedCategory == category) {
        selectedCategory = null;
      } else {
        selectedCategory = category;
        if (selectedSeason != null && selectedCategory != null) {
          String newTag = '#${selectedSeason}_${selectedCategory}';
          if (!selectedTags.contains(newTag)) {
            selectedTags.add(newTag);  // 기존 태그 유지하고 새 태그 추가
          }
        }
      }
    });
  }

  // 해시태그 위젯
  Widget _buildHashTags() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            ...selectedTags.map((tag) {
              final tagParts = tag.substring(1).split('_');
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getSeasonalBgColor(tagParts[0], tagParts[1]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        color: getSeasonalColor(tagParts[0], tagParts[1]),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTags.remove(tag);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: getSeasonalColor(tagParts[0], tagParts[1]),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> post) {
    String productId = post['id'];
    bool isFavorite = favoriteStates[productId] ?? false;

    // itemId에 따른 이미지 파일명 매핑
    String getImagePath(String itemId) {
      Map<String, String> imageMapping = {
        "1": "dress1",
        "2": "dress2",
        "3": "dress3",
        "4": "dress4",
        "5": "outter1",
        "6": "outter2",
        "7": "pants1",
        "8": "pants2",
        "9": "top1",
        "10": "top2",
        "11": "top3",
        "12": "spring_bright_1",
        "13": "autumn_deep_1",
        "14": "winter_bright_1",
      };
      return 'assets/images/closet/${imageMapping[post['itemId']]}.jpeg';  // 경로 수정
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
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
                child: Image.asset(
                  getImagePath(post['itemId']),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image load error: $error');  // 에러 로그 추가
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${post['price']}원',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${post['chatCount']}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
  // 선택된 카테고리에 따라 게시물 필터링
  List<Map<String, dynamic>> getFilteredPosts() {
    final posts = dummyPostApiResponse['data']['posts'] as List;
    return posts.where((post) {
      bool matchesClothingType = true;
      bool matchesPersonalColor = true;

      // 의류 타입 필터링
      if (selectedClothingType != '전체') {
        switch (selectedClothingType) {
          case '아우터':
            matchesClothingType = post['category'] == '아우터';
            break;
          case '상의':
            matchesClothingType = post['category'] == '상의';
            break;
          case '바지':
            matchesClothingType = post['category'] == '바지';
            break;
          case '치마/원피스':
            matchesClothingType = post['category'] == '원피스';
            break;
        }
      }

      // 퍼스널컬러 태그 필터링
      if (selectedTags.isNotEmpty) {
        matchesPersonalColor = selectedTags.any((tag) {
          final tagParts = tag.substring(1).split('_');
          if (tagParts.length == 2) {
            final season = tagParts[0];
            final tone = tagParts[1];
            
            return post['personalColor']['season'] == season &&
                   post['personalColor']['tone'] == tone;
          }
          return false;
        });
      }

      return matchesClothingType && matchesPersonalColor;
    }).toList().cast<Map<String, dynamic>>();
  }

  // 하단 네비게이션 탭 콜백 추가
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // 선택된 인덱스에 따라 페이지 전환

      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedClothingType = category['label']!;
                        });
                      },
                      child: Container(
                        width: 85,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.black : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                category['image']!,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['label']!,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.grey[600],
                                fontSize: category['label'] == '치마/원피스' ? 13.5 : 14,
                                decoration: TextDecoration.none,  // 명시적으로 밑줄 제거
                              ),
                            ),
                          ],
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
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            children: seasons.map((season) {
              final isSelected = season == selectedSeason;
              return Expanded(
                child: GestureDetector(
                  onTap: () => selectSeason(season),
                  child: Container(
                    alignment: Alignment.center,
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
          // 선택된 항목의 밑줄만 표시
          if (selectedSeason != null)
            Positioned(
              bottom: 0,
              left: seasons.indexOf(selectedSeason!) * (MediaQuery.of(context).size.width / 4),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 2,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }

  // 컬러 카테고리 행
  Widget _buildDynamicCategoryRow() {
    final categories = selectedSeason != null 
        ? seasonCategories[selectedSeason]! 
        : <String>[];
    return Container(
      height: 45,
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = category == selectedCategory;
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => selectCategory(category),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        category,
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
          ),
          // 선택된 항목의 밑줄만 표시
          if (selectedCategory != null)
            Positioned(
              bottom: 0,
              left: categories.indexOf(selectedCategory!) * 116,  // 100(width) + 16(margin)
              child: Container(
                width: 100,
                height: 2,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }

  // 해시태그 선택 처리
  void _handleTagSelection(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);  // 기존 태그 유지하고 새 태그 추가
      }
    });
  }

  // 의류 타입 선택 처리
  void _handleClothingTypeSelection(String type) {
    setState(() {
      selectedClothingType = type;
    });
  }
}

// 홈 페이지 컴포넌트 이름 변경
class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  String? selectedSeason;
  String? selectedCategory;
  String selectedClothingType = '아우터';
  List<String> selectedTags = [];
  Map<String, bool> favoriteStates = {};

  final Map<String, List<String>> seasonCategories = {
    '봄': ['라이트', '브라이트', '트루'],
    '여름': ['라이트', '뮤트', '트루'],
    '가을': ['뮤트', '딥', '트루'],
    '겨울': ['브라이트', '딥', '트루'],
  };

  // colorMap 추가
  final Map<String, ColorPair> colorMap = {
    '봄_라이트': ColorPair(const Color(0xFFFFF4C2), const Color(0xFFFBD931)),
    '봄_트루': ColorPair(const Color(0xFFFFD9AC), const Color(0xFFFDA844)),
    '봄_브라이트': ColorPair(const Color(0xFFFFC5C5), const Color(0xFFF06260)),
    '여름_라이트': ColorPair(const Color(0xFFC2EBFF), const Color(0xFF84CAEC)),
    '여름_트루': ColorPair(const Color(0xFF9BCFFB), const Color(0xFF346EA0)),
    '여름_뮤트': ColorPair(const Color(0xFFC2B4E2), const Color(0xFF8977B5)),
    '가을_뮤트': ColorPair(const Color(0xFFB3C397), const Color(0xFF86956D)),
    '가을_트루': ColorPair(const Color(0xFFDBBD9B), const Color(0xFFB4926D)),
    '가을_딥': ColorPair(const Color(0xFFA8878F), const Color(0xFF442129)),
    '겨울_브라이트': ColorPair(const Color(0xFF89F6E6), const Color(0xFF1FA793)),
    '겨울_트루': ColorPair(const Color(0xFF302221), Colors.white),
    '겨울_딥': ColorPair(const Color(0xFF519AA9), const Color(0xFF17383F)),
  };

  // toggleFavorite 함수 추가
  void toggleFavorite(String postId) {
    setState(() {
      final posts = dummyPostApiResponse['data']['posts'] as List<dynamic>;
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        posts[postIndex]['isFavorite'] = !posts[postIndex]['isFavorite'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(),
            _buildFixedCategoryRow(),
            _buildSeasonRow(),
            if (selectedSeason != null) _buildDynamicCategoryRow(),
            if (selectedTags.isNotEmpty) _buildHashTags(),
            const SizedBox(height: 20),  // 여백 추가
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: getFilteredPosts().map((product) => ProductCard(
                  product: product,
                  colorMap: colorMap,
                  onFavoritePressed: toggleFavorite,
                  isGridView: true,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 계절별 색상 매핑
  Color getSeasonalColor(String? season, String? category) {
    if (season == null || category == null) return Colors.black;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightFont;
      if (category == '브라이트') return AppColors.springBrightFont;
      if (category == '트루') return AppColors.springTrueFont;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightFont;
      if (category == '뮤트') return AppColors.summerMuteFont;
      if (category == '트루') return AppColors.summerTrueFont;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepFont;
      if (category == '뮤트') return AppColors.autumnMuteFont;
      if (category == '트루') return AppColors.autumnTrueFont;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepFont;
      if (category == '브라이트') return AppColors.winterBrightFont;
      if (category == '트루') return AppColors.winterTrueFont;
    }
    return Colors.black;
  }

  // 계절별 배경색 매핑
  Color getSeasonalBgColor(String? season, String? category) {
    if (season == null || category == null) return Colors.grey.shade200;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightBg;
      if (category == '브라이트') return AppColors.springBrightBg;
      if (category == '트루') return AppColors.springTrueBg;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightBg;
      if (category == '뮤트') return AppColors.summerMuteBg;
      if (category == '트루') return AppColors.summerTrueBg;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepBg;
      if (category == '뮤트') return AppColors.autumnMuteBg;
      if (category == '트루') return AppColors.autumnTrueBg;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepBg;
      if (category == '브라이트') return AppColors.winterBrightBg;
      if (category == '트루') return AppColors.winterTrueBg;
    }
    return Colors.grey.shade200;
  }

  // 계절 선택 시
  void selectSeason(String season) {
    setState(() {
      if (selectedSeason == season) {
        selectedSeason = null;
      } else {
        selectedSeason = season;
      }
    });
  }

  // 카테고리 선택 시
  void selectCategory(String category) {
    setState(() {
      if (selectedCategory == category) {
        selectedCategory = null;
      } else {
        selectedCategory = category;
        if (selectedSeason != null && selectedCategory != null) {
          String newTag = '#${selectedSeason}_${selectedCategory}';
          if (!selectedTags.contains(newTag)) {
            selectedTags.add(newTag);  // 기존 태그 유지하고 새 태그 추가
          }
        }
      }
    });
  }

  // 해시태그 위젯
  Widget _buildHashTags() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            ...selectedTags.map((tag) {
              final tagParts = tag.substring(1).split('_');
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getSeasonalBgColor(tagParts[0], tagParts[1]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        color: getSeasonalColor(tagParts[0], tagParts[1]),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTags.remove(tag);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: getSeasonalColor(tagParts[0], tagParts[1]),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // 선택된 카테고리에 따라 게시물 필터링
  List<Map<String, dynamic>> getFilteredPosts() {
    final posts = dummyPostApiResponse['data']['posts'] as List;
    return posts.where((post) {
      bool matchesClothingType = true;
      bool matchesPersonalColor = true;

      // 의류 타입 필터링
      if (selectedClothingType != '전체') {
        switch (selectedClothingType) {
          case '아우터':
            matchesClothingType = post['category'] == '아우터';
            break;
          case '상의':
            matchesClothingType = post['category'] == '상의';
            break;
          case '바지':
            matchesClothingType = post['category'] == '바지';
            break;
          case '치마/원피스':
            matchesClothingType = post['category'] == '원피스';
            break;
        }
      }

      // 퍼스널컬러 태그 필터링
      if (selectedTags.isNotEmpty) {
        matchesPersonalColor = selectedTags.any((tag) {
          final tagParts = tag.substring(1).split('_');
          if (tagParts.length == 2) {
            final season = tagParts[0];
            final tone = tagParts[1];
            
            return post['personalColor']['season'] == season &&
                   post['personalColor']['tone'] == tone;
          }
          return false;
        });
      }

      return matchesClothingType && matchesPersonalColor;
    }).toList().cast<Map<String, dynamic>>();
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedClothingType = category['label']!;
                        });
                      },
                      child: Container(
                        width: 85,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? Colors.black : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                category['image']!,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['label']!,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.grey[600],
                                fontSize: category['label'] == '치마/원피스' ? 13.5 : 14,
                                decoration: TextDecoration.none,  // 명시적으로 밑줄 제거
                              ),
                            ),
                          ],
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
      color: Colors.white,
      child: Stack(
        children: [
          Row(
            children: seasons.map((season) {
              final isSelected = season == selectedSeason;
              return Expanded(
                child: GestureDetector(
                  onTap: () => selectSeason(season),
                  child: Container(
                    alignment: Alignment.center,
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
          // 선택된 항목의 밑줄만 표시
          if (selectedSeason != null)
            Positioned(
              bottom: 0,
              left: seasons.indexOf(selectedSeason!) * (MediaQuery.of(context).size.width / 4),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 2,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }

  // 컬러 카테고리 행
  Widget _buildDynamicCategoryRow() {
    final categories = selectedSeason != null 
        ? seasonCategories[selectedSeason]! 
        : <String>[];
    return Container(
      height: 45,
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                final isSelected = category == selectedCategory;
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => selectCategory(category),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        category,
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
          ),
          // 선택된 항목의 밑줄만 표시
          if (selectedCategory != null)
            Positioned(
              bottom: 0,
              left: categories.indexOf(selectedCategory!) * 116,  // 100(width) + 16(margin)
              child: Container(
                width: 100,
                height: 2,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}