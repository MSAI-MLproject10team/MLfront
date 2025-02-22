class Post {
  final String id;
  final String title;
  final String seller;
  final String content;
  final String itemId;
  final String status;
  final int price;
  final DateTime createdAt;
  final int viewCount;
  final int likeCount;
  final int chatCount;
  final bool isFavorite;

  Post({
    required this.id,
    required this.title,
    required this.seller,
    required this.content,
    required this.itemId,
    required this.status,
    required this.price,
    required this.createdAt,
    required this.viewCount,
    required this.likeCount,
    required this.chatCount,
    required this.isFavorite,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      seller: json['seller'] as String,
      content: json['content'] as String,
      itemId: json['itemId'] as String,
      status: json['status'] as String,
      price: json['price'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      viewCount: json['viewCount'] as int,
      likeCount: json['likeCount'] as int,
      chatCount: json['chatCount'] as int,
      isFavorite: json['isFavorite'] as bool,
    );
  }
}

final Map<String, dynamic> dummyPostApiResponse = {
  "success": true,
  "message": "Posts retrieved successfully",
  "data": {
    "posts": [
      {
        "id": "p1",
        "title": "플라워 원피스 판매합니다",
        "seller": "미니멀리스트",
        "content": "봄트루톤 추천 원피스에요! 한 번 입어보고 사이즈가 안 맞아서 내놓습니다. 택 포함이에요. 직거래 우선이고, 택배는 +3000원입니다.",
        "itemId": "1",
        "status": "판매중",
        "price": 30000,
        "createdAt": "2024-02-18T09:00:00Z",
        "viewCount": 42,
        "likeCount": 5,
        "chatCount": 3,
        "category": "원피스",
        "isFavorite": true,
        "personalColor": {
          "season": "봄",
          "tone": "트루"
        }
      },
      {
        "id": "p2",
        "title": "셔츠형 원피스 (여름트루톤)",
        "seller": "옷장정리",
        "content": "여름트루톤 셔츠원피스 판매해요. 사무실에서 3번 정도 입었고 상태 좋습니다. 목 부분 약간의 화장품 자국 있어요(사진 참고). 교신 가능!",
        "itemId": "2",
        "status": "예약중",
        "price": 25000,
        "createdAt": "2024-02-17T15:30:00Z",
        "viewCount": 89,
        "likeCount": 12,
        "chatCount": 4,
        "category": "원피스",
        "isFavorite": false,
        "personalColor": {
          "season": "여름",
          "tone": "트루"
        }
      },
      {
        "id": "p3",
        "title": "가을트루톤 플리츠 원피스 새상품",
        "seller": "쇼핑중독",
        "content": "온라인에서 구매했는데 사이즈를 잘못 골랐네요 ㅠㅠ 새상품 그대로입니다. 정가 65000원, 반값에 판매합니다! 네고 가능해요~",
        "itemId": "3",
        "status": "판매중",
        "price": 32000,
        "createdAt": "2024-02-16T12:00:00Z",
        "viewCount": 156,
        "likeCount": 23,
        "chatCount": 8,
        "category": "원피스",
        "isFavorite": false,
        "personalColor": {
          "season": "가을",
          "tone": "트루"
        }
      },
      {
        "id": "p4",
        "title": "겨울트루톤 랩 원피스 싸게 내놓아요",
        "seller": "겨울공주",
        "content": "겨울트루톤 랩원피스입니다. 2번 입었고 드라이클리닝 완료했어요. 사이즈가 커서 판매합니다. 택배비 포함가에요!",
        "itemId": "4",
        "status": "판매중",
        "price": 35000,
        "createdAt": "2024-02-15T18:45:00Z",
        "viewCount": 78,
        "likeCount": 9,
        "chatCount": 2,
        "category": "원피스",
        "isFavorite": false,
        "personalColor": {
          "season": "겨울",
          "tone": "트루"
        }
      },
      {
        "id": "p5",
        "title": "가을트루톤 트렌치코트 판매",
        "seller": "패션왕",
        "content": "가을트루톤 베이직 트렌치코트예요. 작년 가을에 구매해서 5번 정도 입었습니다. 깃 부분 때문에 드라이클리닝 했고, 상태 좋아요!",
        "itemId": "5",
        "status": "판매완료",
        "price": 45000,
        "createdAt": "2024-02-14T10:20:00Z",
        "viewCount": 245,
        "likeCount": 31,
        "chatCount": 6,
        "category": "아우터",
        "isFavorite": false,
        "personalColor": {
          "season": "가을",
          "tone": "트루"
        }
      },
      {
        "id": "p6",
        "title": "봄트루톤 크롭자켓 판매해요",
        "seller": "봄날의햇살",
        "content": "봄트루톤 크롭자켓 판매합니다. 구매 후 한 번도 안 입었어요. 택 그대로 있습니다. 예쁘게 입어주실 분 찾아요~",
        "itemId": "6",
        "status": "판매중",
        "price": 40000,
        "createdAt": "2024-02-13T14:15:00Z",
        "viewCount": 167,
        "likeCount": 28,
        "chatCount": 5,
        "category": "아우터",
        "isFavorite": false,
        "personalColor": {
          "season": "봄",
          "tone": "트루"
        }
      },
      {
        "id": "p7",
        "title": "여름트루톤 와이드 데님 팬츠",
        "seller": "청바지매니아",
        "content": "여름트루톤 와이드 데님입니다. 2개월 전에 구매했고 3번 입었어요. 허리 고무밴드라 착용감 좋습니다. 반값에 판매해요!",
        "itemId": "7",
        "status": "예약중",
        "price": 20000,
        "createdAt": "2024-02-12T16:40:00Z",
        "viewCount": 134,
        "likeCount": 15,
        "chatCount": 4,
        "category": "바지",
        "isFavorite": false,
        "personalColor": {
          "season": "여름",
          "tone": "트루"
        }
      },
      {
        "id": "p8",
        "title": "겨울트루톤 슬랙스 판매",
        "seller": "정장러버",
        "content": "겨울트루톤 슬랙스 판매합니다. 사무실용으로 구매했는데 재택근무하게 되어서 판매해요. 기장 수선 안했고 새상품입니다.",
        "itemId": "8",
        "status": "판매중",
        "price": 28000,
        "createdAt": "2024-02-11T11:30:00Z",
        "viewCount": 98,
        "likeCount": 11,
        "chatCount": 3,
        "category": "바지",
        "isFavorite": false,
        "personalColor": {
          "season": "겨울",
          "tone": "트루"
        }
      },
      {
        "id": "p9",
        "title": "가을트루톤 니트 스웨터",
        "seller": "니트控",
        "content": "가을트루톤 니트 스웨터 판매합니다. 부드러운 소재이고 핏이 예뻐요. 드라이클리닝 했고, 보풀 없습니다. 택배비 포함!",
        "itemId": "9",
        "status": "판매중",
        "price": 22000,
        "createdAt": "2024-02-10T13:25:00Z",
        "viewCount": 187,
        "likeCount": 26,
        "chatCount": 7,
        "category": "상의",
        "isFavorite": false,
        "personalColor": {
          "season": "가을",
          "tone": "트루"
        }
      },
      {
        "id": "p10",
        "title": "봄브라이트 블라우스 새상품",
        "seller": "봄날의코디",
        "content": "봄브라이트 블라우스 새상품 판매합니다. 온라인에서 구매했는데 사이즈가 커서 판매해요. 택 그대로 있어요. 네고 가능합니다!",
        "itemId": "10",
        "status": "판매중",
        "price": 23000,
        "createdAt": "2024-02-09T09:15:00Z",
        "viewCount": 145,
        "likeCount": 19,
        "chatCount": 5,
        "category": "상의",
        "isFavorite": false,
        "personalColor": {
          "season": "봄",
          "tone": "브라이트"
        }
      },
      {
        "id": "p11",
        "title": "여름트루톤 셔츠 판매합니다",
        "seller": "미니멀코디",
        "content": "여름트루톤 셔츠 판매해요. 한 번 입어보고 안 입어서 판매합니다. 얼룩이나 하자 없고 상태 좋아요. 택배비 포함입니다.",
        "itemId": "11",
        "status": "판매중",
        "price": 18000,
        "createdAt": "2024-02-08T17:50:00Z",
        "viewCount": 112,
        "likeCount": 14,
        "chatCount": 3,
        "category": "상의",
        "isFavorite": false,
        "personalColor": {
          "season": "여름",
          "tone": "트루"
        }
      },
      {
        "id": "p12",
        "title": "봄 브라이트 셔츠",
        "seller": "봄브라이트",
        "content": "봄 브라이트 톤의 산뜻한 셔츠입니다. 한 번 입어보고 사이즈가 안 맞아서 내놓습니다. 택 포함이에요.",
        "itemId": "12",
        "status": "판매중",
        "price": 35000,
        "createdAt": "2024-03-15T09:00:00Z",
        "viewCount": 120,
        "likeCount": 25,
        "chatCount": 3,
        "category": "상의",
        "isFavorite": true,
        "personalColor": {
          "season": "봄",
          "tone": "브라이트"
        }
      },
      {
        "id": "p13",
        "title": "가을 딥 니트",
        "seller": "가을딥",
        "content": "가을 딥 톤의 포근한 니트입니다. 부드러운 소재로 착용감이 좋아요. 드라이클리닝 완료했습니다.",
        "itemId": "13",
        "status": "판매중",
        "price": 42000,
        "createdAt": "2024-03-16T09:00:00Z",
        "viewCount": 180,
        "likeCount": 35,
        "chatCount": 5,
        "category": "상의",
        "isFavorite": true,
        "personalColor": {
          "season": "가을",
          "tone": "딥"
        }
      },
      {
        "id": "p14",
        "title": "겨울 브라이트 코트",
        "seller": "겨울브라이트",
        "content": "겨울 브라이트 톤의 세련된 코트입니다. 작년 겨울에 구매해서 3번 정도 입었어요. 상태 좋습니다.",
        "itemId": "14",
        "status": "판매중",
        "price": 89000,
        "createdAt": "2024-03-17T09:00:00Z",
        "viewCount": 250,
        "likeCount": 45,
        "chatCount": 7,
        "category": "아우터",
        "isFavorite": true,
        "personalColor": {
          "season": "겨울",
          "tone": "브라이트"
        }
      }
    ]
  }
}; 