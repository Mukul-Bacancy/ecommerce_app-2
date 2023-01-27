import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_product_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FakeProductRepository Test', () {
    test('getProductList returns global list', () {
      final productRepository = FakeProductRepository();
      expect(productRepository.getProductsList(), kTestProducts);
    });

    test('getProduct(1) returns first item', () {
      final productRepository = FakeProductRepository();
      expect(
        productRepository.getProduct('1'),
        kTestProducts[0],
      );
    });

    test('getProduct(100) returns null', () {
      final productRepository = FakeProductRepository();
      expect(
        productRepository.getProduct('100'),
        null,
      );
    });
    
  });
}
