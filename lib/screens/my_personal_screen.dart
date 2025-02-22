import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_card.dart';
import '../models/color_pair.dart';
import '../models/post_response.dart';
import './product_detail_screen.dart';

class MyPersonalScreen extends StatefulWidget {
  const MyPersonalScreen({super.key});

  @override
  State<MyPersonalScreen> createState() => _MyPersonalScreenState();
}

class _MyPersonalScreenState extends State<MyPersonalScreen> {
  bool _showPalette = false;

  final List<String> selectedTags = ['가을_트루'];

  // seasonCategories 추가
  final Map<String, List<String>> seasonCategories = {
    '봄': ['라이트', '브라이트', '트루'],
    '여름': ['라이트', '뮤트', '트루'],
    '가을': ['뮤트', '딥', '트루'],
    '겨울': ['브라이트', '딥', '트루'],
  };

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

  // 필터링된 상품 목록을 가져오는 함수
  List<Map<String, dynamic>> getFilteredPosts() {
    final posts = getMyPosts();
    return posts.where((post) {
      final personalColor = post['personalColor'];
      final tag = '${personalColor['season']}_${personalColor['tone']}';
      return selectedTags.contains(tag);
    }).toList();
  }

  Set<String> getAllPersonalColorTags() {
    final posts = getMyPosts();
    return posts.map((post) {
      final personalColor = post['personalColor'];
      return '${personalColor['season']}_${personalColor['tone']}';
    }).toSet();
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

  // 내가 등록한 상품 목록을 가져오는 함수
  List<Map<String, dynamic>> getMyPosts() {
    final posts = dummyPostApiResponse['data']['posts'] as List<dynamic>;
    // 임시로 모든 게시물을 내 게시물로 처리
    return posts.cast<Map<String, dynamic>>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = getFilteredPosts();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 16.0, right: 16.0, bottom: 5.0),
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                color: const Color(0xFF87CCFD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // + 버튼과 팔레트 영역
          SizedBox(
            height: _showPalette ? 270 : 64,
            child: Stack(
              children: [
                // + 버튼
                Positioned(
                  left: 16,
                  top: 16,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPalette = !_showPalette;
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _showPalette ? Icons.close : Icons.add,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                // 팔레트
                if (_showPalette)
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 12, right: 12,top:5),
                      color: Colors.white,
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1.4,
                        children: [
                          // 봄
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('봄_라이트')) {
                                  selectedTags.add('봄_라이트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['봄_라이트']?.background,
                              child: Center(child: Text('# 봄_라이트', style: TextStyle(color: colorMap['봄_라이트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('여름_라이트')) {
                                  selectedTags.add('여름_라이트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['여름_라이트']?.background,
                              child: Center(child: Text('# 여름_라이트', style: TextStyle(color: colorMap['여름_라이트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('가을_뮤트')) {
                                  selectedTags.add('가을_뮤트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['가을_뮤트']?.background,
                              child: Center(child: Text('# 가을_뮤트', style: TextStyle(color: colorMap['가을_뮤트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('겨울_브라이트')) {
                                  selectedTags.add('겨울_브라이트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['겨울_브라이트']?.background,
                              child: Center(child: Text('# 겨울_브라이트', style: TextStyle(color: colorMap['겨울_브라이트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('봄_트루')) {
                                  selectedTags.add('봄_트루');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['봄_트루']?.background,
                              child: Center(child: Text('# 봄_트루', style: TextStyle(color: colorMap['봄_트루']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('여름_트루')) {
                                  selectedTags.add('여름_트루');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['여름_트루']?.background,
                              child: Center(child: Text('# 여름_트루', style: TextStyle(color: colorMap['여름_트루']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('가을_트루')) {
                                  selectedTags.add('가을_트루');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['가을_트루']?.background,
                              child: Center(child: Text('# 가을_트루', style: TextStyle(color: colorMap['가을_트루']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('겨울_트루')) {
                                  selectedTags.add('겨울_트루');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['겨울_트루']?.background,
                              child: Center(child: Text('# 겨울_트루', style: TextStyle(color: colorMap['겨울_트루']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('봄_브라이트')) {
                                  selectedTags.add('봄_브라이트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['봄_브라이트']?.background,
                              child: Center(child: Text('# 봄_브라이트', style: TextStyle(color: colorMap['봄_브라이트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('여름_뮤트')) {
                                  selectedTags.add('여름_뮤트');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['여름_뮤트']?.background,
                              child: Center(child: Text('# 여름_뮤트', style: TextStyle(color: colorMap['여름_뮤트']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('가을_딥')) {
                                  selectedTags.add('가을_딥');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['가을_딥']?.background,
                              child: Center(child: Text('# 가을_딥', style: TextStyle(color: colorMap['가을_딥']?.text, fontSize: 12))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedTags.contains('겨울_딥')) {
                                  selectedTags.add('겨울_딥');
                                }
                                _showPalette = false;
                              });
                            },
                            child: Container(
                              color: colorMap['겨울_딥']?.background,
                              child: Center(child: Text('# 겨울_딥', style: TextStyle(color: colorMap['겨울_딥']?.text, fontSize: 12))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // 선택된 태그들 표시
          if (selectedTags.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedTags.map((tag) {
                    final colorPair = colorMap[tag];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorPair?.background ?? Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '# $tag',
                            style: TextStyle(
                              color: colorPair?.text ?? Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTags.remove(tag);
                              });
                            },
                            child: Text(
                              'X',
                              style: TextStyle(
                                color: colorPair?.text ?? Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Expanded(
            child: Container(
              color: Colors.white,
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
          ),
        ],
      ),
    );
  }
} 