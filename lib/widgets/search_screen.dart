import 'package:flutter/material.dart';
import '../colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];
  bool isSearching = false;

  void _performSearch(String query) {
    if (query.isEmpty) return;

    setState(() {
      isSearching = true;
      // 예시 데이터 - 실제 데이터로 교체 필요
      searchResults = [
        '#봄_라이트',
        '#봄_브라이트',
        '#봄_웜',
        '#여름_라이트',
        '#여름_뮤트',
        '#여름_쿨',
      ].where((tag) => 
        tag.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: '검색어를 입력하세요',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: _performSearch,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                onPressed: () => _performSearch(searchController.text),
              ),
            ],
          ),
        ),
      ),
      body: isSearching && searchResults.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: searchResults.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    searchResults[index],
                    style: TextStyle(
                      color: getSeasonalColor(
                        searchResults[index].split('_')[0].substring(1),
                        searchResults[index].split('_')[1],
                      ),
                    ),
                  ),
                  onTap: () {
                    // 검색 결과 선택 시 처리
                  },
                );
              },
            )
          : Center(
              child: Text(
                '검색어를 입력하세요',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
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
} 