import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'product_detail_screen.dart';
import '../widgets/custom_app_bar.dart';
// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.favorite,
//             size: 48,
//             color: Colors.red[300],
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             '찜 목록이 비었습니다.',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // 선택된 태그 목록
  Set<String> selectedTags = {'봄_브라이트', '가을_딥'}; // 초기 선택 태그

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

  // 태그 선택/해제 기능
  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  // 샘플 상품 데이터 (태그 포함)
  final List<Map<String, String>> products = [
    {'image': 'assets/images/spring_bright_1.png', 'tag': '봄_브라이트', 'id': '001', 'name': '봄 브라이트 상의', 'price': '5000원'},
    {'image': 'assets/images/autumn_deep_1.png', 'tag': '가을_딥', 'id': '002', 'name': '가을 딥 상의', 'price': '15000원'},
    {'image': 'assets/images/winter_bright_1.png', 'tag': '겨울_브라이트', 'id': '003', 'name': '겨울 브라이트 상의', 'price': '25000원'},
  ];

  @override
  Widget build(BuildContext context) {
    // 필터링된 상품 리스트
    final filteredProducts = products.where((product) =>
        selectedTags.contains(product['tag'])).toList();
    if (kDebugMode) {
      print("필터링된 상품 개수: ${filteredProducts.length}");
      if (filteredProducts.isEmpty) {
        print("비어 있음");
      }
    }

    return Column(
        children: [
          // 상단: 태깅, 하단: 상품 목록
          Expanded( // 상단
            // width: MediaQuery.of(context).size.width * 0.9, // 화면 크기에 맞게 조정
            // height: MediaQuery.of(context).size.height * 0.9,
            // decoration: BoxDecoration(color: Colors.white),
            child: Stack(

                children: [
                  // 태그 필터 버튼
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                    // left: 21,
                    // top: 21,
                    child: Wrap(
                      spacing: 8.0, // 태그 간격
                      runSpacing: 4.0, // 줄 간격
                      children: tagColors.keys.map<Widget>((tag) {
                        bool isSelected = selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () => toggleTag(tag),
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: ShapeDecoration(
                              color: isSelected ? tagColors[tag] : Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '# $tag',
                                    style: TextStyle(
                                      color: isSelected ? fontColors[tag] : Colors
                                          .grey[700],
                                      fontSize: 16,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ]
            ),
          ),
          //하단
          // 상품 리스트 or 찜 목록 없음 메시지
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                // 상품 리스트 or 찜 목록 없음 메시지
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 2, right: 50),
                  child: filteredProducts.isEmpty
                      ? Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Icon(
                          Icons.favorite,
                          size: 48,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '찜 목록이 비었습니다.',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                      :
                  Column(

                    children: filteredProducts.map((product) {

                      return  GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductDetailScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start, // 세로로 정렬 시작점 맞추기
                            children: [
                              Image.asset(
                                product['image'] ?? '',
                                width: 150,
                                height: 150, // 이미지 높이를 일정하게 설정,
                                fit: BoxFit.cover, // 이미지를 잘 맞게 보이도록 설정
                              ),
                              SizedBox(width: 12), // 이미지와 텍스트 사이 간격
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // 오른쪽 텍스트 세로로 왼쪽 정렬
                                  children: [
                                    Text(
                                      product['name'] ?? '',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    SizedBox(height: 4), // 이름과 태그 사이 간격
                                    Text(
                                      product['tag'] ?? '',
                                      style: TextStyle(color: Colors.grey, fontSize: 14),
                                    ),
                                    SizedBox(height: 4), // 태그와 가격 사이 간격
                                    Text(
                                      product['price'] ?? '',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              // 상단 하트 아이콘
              // child: Positioned(
              //   left: 520,
              //   top: 20,
              //   child: Image.asset('assets/images/hearts.png', width: 34, height: 34),
              // )

              //
            ),
          ),
        ]);
  }

// 상품 카드
  Widget _buildProductCard() {
    String productId = "1";
    bool isFavorite = true; //favoriteStates[productId] ?? false;

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
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                //   setState(() {
                //     favoriteStates[productId] = !isFavorite;
                //   });
              },
            ),
          ],
        ),
      ),
    );
  }
}