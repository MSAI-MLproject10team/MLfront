import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../models/color_pair.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Map<String, ColorPair> colorMap;
  final Function(String)? onFavoritePressed;
  final bool isGridView;

  const ProductCard({
    super.key,
    required this.product,
    required this.colorMap,
    this.onFavoritePressed,
    this.isGridView = false,
  });

  String getImagePath(String itemId) {
    Map<String, String> imageMapping = {
      "1": "dress1.jpeg",
      "2": "dress2.jpeg",
      "3": "dress3.jpeg",
      "4": "dress4.jpeg",
      "5": "outter1.jpeg",
      "6": "outter2.jpeg",
      "7": "pants1.jpeg",
      "8": "pants2.jpeg",
      "9": "top1.jpeg",
      "10": "top2.jpeg",
      "11": "top3.jpeg",
      "12": "spring_bright_1.png",
      "13": "autumn_deep_1.png",
      "14": "winter_bright_1.png",
    };

    final fileName = imageMapping[itemId];
    if (fileName == null) {
      return '';
    }
    return 'assets/images/closet/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    final personalColor = product['personalColor'];
    final tag = '${personalColor['season']}_${personalColor['tone']}';

    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1.5,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 상품 이미지
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Image.asset(
              getImagePath(product['itemId']),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          // 상품 정보
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 제목
                  Text(
                    product['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // 퍼스널 컬러 태그
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorMap[tag]?.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '# $tag',
                      style: TextStyle(
                        color: colorMap[tag]?.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // 가격과 액션 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product['price']}원',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          // 채팅 수
                          Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 20,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product['chatCount'] ?? 0}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // 찜하기 버튼
                          if (onFavoritePressed != null)
                            GestureDetector(
                              onTap: () => onFavoritePressed!(product['id']),
                              child: Icon(
                                product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                color: product['isFavorite'] ? Colors.red[400] : Colors.grey[600],
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 