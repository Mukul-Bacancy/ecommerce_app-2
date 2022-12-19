import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductRepository {
  //Singleton Pattern for Dependecy Injection (Temporary)
  FakeProductRepository._(); // stops from creating multiple instances of this class
  static FakeProductRepository instance = FakeProductRepository._();

  final List<Product> _products = kTestProducts;
  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map(
      (products) => products.firstWhere((product) => product.id == id),
    );
  }
}
