import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import '../models/post_response.dart';
import 'product_detail_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_card.dart';
import '../models/color_pair.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Set을 List로 변경하여 선택 순서도 유지
  final List<String> deactivatedTags = [];

  // 태그 색상 설정

  final Map<String, Color> tagColors = {
    '봄_브라이트': AppColors.springBrightBg,
    '가을_딥': AppColors.autumnDeepBg,
    '겨울_브라이트': AppColors.winterBrightBg,
  };

  final Map<String, Color> fontColors = {
    '봄_브라이트': AppColors.springBrightFont,
    '가을_딥': AppColors.autumnDeepFont,
    '겨울_브라이트': AppColors.winterBrightFont,
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

  // 모든 찜한 상품의 퍼스널 컬러 태그를 가져오는 함수
  Set<String> getAllPersonalColorTags() {
    final posts = getFavoritePosts();
    return posts.map((post) {
      final personalColor = post['personalColor'];
      return '${personalColor['season']}_${personalColor['tone']}';
    }).toSet();
  }

  // 필터링된 찜 목록을 가져오는 함수 수정
  List<Map<String, dynamic>> getFilteredFavoritePosts() {
    final posts = getFavoritePosts();
    if (deactivatedTags.isEmpty) return posts;
    
    return posts.where((post) {
      final personalColor = post['personalColor'];
      final tag = '${personalColor['season']}_${personalColor['tone']}';
      return !deactivatedTags.contains(tag);
    }).toList();
  }

  void toggleFavorite(String postId) {
    setState(() {
      final posts = dummyPostApiResponse['data']['posts'] as List<dynamic>;
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        posts[postIndex]['isFavorite'] = !posts[postIndex]['isFavorite'];
      }
    });
  }

  List<Map<String, dynamic>> getFavoritePosts() {
    final posts = dummyPostApiResponse['data']['posts'] as List<dynamic>;
    return posts.where((post) => post['isFavorite'] == true).cast<Map<String, dynamic>>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final allTags = getAllPersonalColorTags();
    final filteredPosts = getFilteredFavoritePosts();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 3.0,
                left: 16.0,
                right: 16.0,
                bottom: 5.0,
              ),
              child: Container(
                height: 2.5,
                decoration: BoxDecoration(
                  color: const Color(0xFF87CCFD),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (allTags.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: allTags.map((tag) {
                      final isActive = !deactivatedTags.contains(tag);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isActive) {
                              // 이미 활성화된 태그를 비활성화
                              deactivatedTags.add(tag);
                            } else {
                              // 비활성화된 태그를 다시 활성화
                              deactivatedTags.remove(tag);
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? colorMap[tag]?.background
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(  // 테두리 추가
                              color: isActive
                                  ? Colors.transparent
                                  : Colors.grey[400] ?? Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Row(  // Row로 변경하여 아이콘 추가
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '# $tag',
                                style: TextStyle(
                                  color: isActive
                                      ? colorMap[tag]?.text
                                      : Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isActive) ...[  // 비활성화된 경우에만 X 아이콘 표시
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            Container(
              height: 1,
              color: Colors.grey[200],
            ),
            Expanded(
              child: filteredPosts.isEmpty
                  ? const Center(
                      child: Text(
                        '표시할 상품이 없습니다',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredPosts[index],
                          colorMap: colorMap,
                          onFavoritePressed: toggleFavorite,
                          isGridView: false,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}