import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/productDetail': (context) => ProductDetailScreen(), // 기본값 설정 제거
        '/upload': (context) => UploadScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final productId = args['productId'];

    return Scaffold(
      appBar: AppBar(
        title: Text('상품 상세'),
      ),
      body: Center(
        child: Text('상품 ID: $productId'),
      ),
    );
  }
}
