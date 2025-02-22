import 'package:flutter/material.dart';
import '../colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String selectedClothingType = '상의';
  List<String> selectedTags = ['#봄_브라이트'];

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
        title: const Text(
          '게시물 등록',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 업로드 영역
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 118,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // 해시태그를 이미지 좌측 하단에 배치
                  Positioned(
                    left: 14,
                    bottom: 12,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: selectedTags.map((tag) {
                        final tagParts = tag.substring(1).split('_');
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: getSeasonalBgColor(tagParts[0], tagParts[1]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: getSeasonalColor(tagParts[0], tagParts[1]),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 의류 카테고리
              Container(
                height: 42,
                child: Row(
                  children: ['아우터', '상의', '바지', '치마/원피스'].map((type) {
                    final isSelected = type == selectedClothingType;
                    return Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedClothingType = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.black : Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              type,
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF5B5B5B),
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // 버튼 영역
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '사진 올리기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '색깔 추출 🔍',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 입력 필드들
              _buildInputField('거래 가격', '₩ 가격을 입력해주세요.'),
              _buildInputField('글 제목', '게시글 제목을 작성해주세요.'),
              _buildInputField('자세한 설명', '게시글 내용을 작성해주세요.', maxLines: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
} 