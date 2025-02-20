import 'package:flutter/material.dart';

class MyPersonalScreen extends StatefulWidget {
  const MyPersonalScreen({super.key});

  @override
  State<MyPersonalScreen> createState() => _MyPersonalScreenState();
}

class _MyPersonalScreenState extends State<MyPersonalScreen> {
  bool _showPalette = false;
  List<String> selectedTags = ['여름_라이트']; // 기본값으로 여름_라이트 설정

  final Map<String, ColorPair> colorMap = {
    '봄_라이트': ColorPair(const Color(0xFFFFF4C2), const Color(0xFFFBD931)),
    '봄_웜': ColorPair(const Color(0xFFFFD9AC), const Color(0xFFFDA844)),
    '봄_브라이트': ColorPair(const Color(0xFFFFC5C5), const Color(0xFFF06260)),
    '여름_라이트': ColorPair(const Color(0xFFC2EBFF), const Color(0xFF84CAEC)),
    '여름_쿨': ColorPair(const Color(0xFF9BCFFB), const Color(0xFF346EA0)),
    '여름_뮤트': ColorPair(const Color(0xFFC2B4E2), const Color(0xFF8977B5)),
    '가을_뮤트': ColorPair(const Color(0xFFB3C397), const Color(0xFF86956D)),
    '가을_웜': ColorPair(const Color(0xFFDBBD9B), const Color(0xFFB4926D)),
    '가을_딥': ColorPair(const Color(0xFFA8878F), const Color(0xFF442129)),
    '겨울_브라이트': ColorPair(const Color(0xFF89F6E6), const Color(0xFF1FA793)),
    '겨울_쿨': ColorPair(const Color(0xFF302221), Colors.white),
    '겨울_딥': ColorPair(const Color(0xFF519AA9), const Color(0xFF17383F)),
  };

  @override
  void initState() {
    super.initState();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 + 버튼
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPalette = !_showPalette;
                    });
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      _showPalette ? Icons.remove : Icons.add,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 팔레트 영역
          if (_showPalette)
            Container(
              height: 240,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              margin: const EdgeInsets.only(bottom: 1.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 2.1,
                children: colorMap.entries.map((entry) {
                  return _buildColorTile(
                    entry.key,
                    entry.value.background,
                    entry.value.text,
                  );
                }).toList(),
              ),
            ),

          // 선택된 해시태그 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: selectedTags.map((tag) {
                  final colors = colorMap[tag]!;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '# $tag',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _toggleTag(tag),
                          child: Text(
                            'X',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
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
        ],
      ),
    );
  }

  Widget _buildColorTile(String tag, Color backgroundColor, Color textColor) {
    return GestureDetector(
      onTap: () => _toggleTag(tag),
      child: Container(
        color: backgroundColor,
        child: Center(
          child: Text(
            '# $tag',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ColorPair {
  final Color background;
  final Color text;

  ColorPair(this.background, this.text);
} 