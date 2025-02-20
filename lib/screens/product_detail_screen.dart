import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;  // 게시물 데이터 추가

  const ProductDetailScreen({
    super.key,
    required this.post,  // 필수 파라미터로 변경
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  
  // 이미지 경로 생성 함수
  String getImagePath() {
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
    
    String? imageName = imageMapping[widget.post['itemId']];
    return 'assets/images/closet/${imageName ?? widget.post['itemId']}.jpeg';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        title: Text(
          widget.post['title'],  // 게시물 제목 표시
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 슬라이더
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: 1,  // 현재는 이미지 1개만 표시
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Image.asset(
                          getImagePath(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[400],
                                size: 50,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목과 좋아요 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.post['title'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // 판매자 정보
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post['seller'],  // 판매자 이름
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${widget.post['personalColor']['season']}_${widget.post['personalColor']['tone']}',  // 퍼스널컬러 정보
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.post['price']}원',  // 가격
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.post['status'],  // 판매 상태
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // 상품 설명
                  Text(
                    widget.post['content'],  // 상품 설명
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 추천 상품 섹션
                  const Text(
                    'OO님의 퍼스널 추천상품',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 추천 상품 그리드
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text('추천 상품'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}