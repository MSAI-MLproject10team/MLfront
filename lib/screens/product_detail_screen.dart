import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final int? productId;

  ProductDetailScreen({this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 상세'),
      ),
      body: Center(
        child: Text('상품 ID: ${productId ?? '알 수 없음'}'),
      ),
    );
  }
}