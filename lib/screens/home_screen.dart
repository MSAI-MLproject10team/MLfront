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
    '봄': ['라이트', '브라이트', '웜'],
    '여름': ['라이트', '뮤트', '쿨'],
    '가을': ['뮤트', '딥', '웜'],
    '겨울': ['브라이트', '딥', '쿨'],
  };

  // 계절별 색상 매핑
  Color getSeasonalColor(String? season, String? category) {
    if (season == null || category == null) return Colors.black;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightFont;
      if (category == '브라이트') return AppColors.springBrightFont;
      if (category == '웜') return AppColors.springWarmFont;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightFont;
      if (category == '뮤트') return AppColors.summerMuteFont;
      if (category == '쿨') return AppColors.summerCoolFont;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepFont;
      if (category == '뮤트') return AppColors.autumnMuteFont;
      if (category == '웜') return AppColors.autumnWarmFont;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepFont;
      if (category == '브라이트') return AppColors.winterBrightFont;
      if (category == '쿨') return AppColors.winterCoolFont;
    }
    return Colors.black;
  }

  // 계절별 배경색 매핑
  Color getSeasonalBgColor(String? season, String? category) {
    if (season == null || category == null) return Colors.grey.shade200;
    
    if (season == '봄') {
      if (category == '라이트') return AppColors.springLightBg;
      if (category == '브라이트') return AppColors.springBrightBg;
      if (category == '웜') return AppColors.springWarmBg;
    } else if (season == '여름') {
      if (category == '라이트') return AppColors.summerLightBg;
      if (category == '뮤트') return AppColors.summerMuteBg;
      if (category == '쿨') return AppColors.summerCoolBg;
    } else if (season == '가을') {
      if (category == '딥') return AppColors.autumnDeepBg;
      if (category == '뮤트') return AppColors.autumnMuteBg;
      if (category == '웜') return AppColors.autumnWarmBg;
    } else { // 겨울
      if (category == '딥') return AppColors.winterDeepBg;
      if (category == '브라이트') return AppColors.winterBrightBg;
      if (category == '쿨') return AppColors.winterCoolBg;
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
                      Icons.close,  // remove_circle_outline에서 close로 변경
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

      // 디버그 로그 추가
      print('Post ID: ${post['id']}');
      print('Category: ${post['category']}');
      print('Status: ${post['status']}');
      print('Title: ${post['title']}');

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

      // 디버그 로그 추가
      print('Matches Clothing Type: $matchesClothingType');
      print('-------------------');

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

  @override
  Widget build(BuildContext context) {
    final filteredPosts = getFilteredPosts();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _selectedIndex != 2 ? const CustomAppBar() : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFixedCategoryRow(),
                _buildSeasonRow(),
                _buildDynamicCategoryRow(),
                _buildHashTags(),
                if (filteredPosts.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        '해당하는 상품이 없습니다.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  post: post,  // 선택된 게시물 데이터 전달
                                ),
                              ),
                            );
                          },
                          child: _buildProductCard(post),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          const FavoriteScreen(),
          const PostScreen(),
          const MyPersonalScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
              onTap: () => selectSeason(season),
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
    final categories = selectedSeason != null 
        ? seasonCategories[selectedSeason]! 
        : <String>[];
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Container(
            width: 100,  // 고정된 너비 설정
            margin: const EdgeInsets.only(right: 16),  // 카테고리 간 간격
            child: GestureDetector(
              onTap: () => selectCategory(category),
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