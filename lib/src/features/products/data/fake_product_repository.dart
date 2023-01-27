import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {
  final List<Product> _products = kTestProducts;
  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _getProduct(_products, id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));

    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map(
      (products) => _getProduct(products, id),
    );
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}

final productsRepositoryProvider = Provider<FakeProductRepository>(
  (ref) {
    return FakeProductRepository();
  },
);

final productListStreamProvider = StreamProvider.autoDispose<List<Product>>(
  (ref) {
    debugPrint('created productListStreamProvider');
    final productRepository = ref.watch(productsRepositoryProvider);
    return productRepository.watchProductsList();
  },
); //Stream Provider

//* Stream and Future providers defintion is same just differs in working
final productListFutureProvider = FutureProvider.autoDispose<List<Product>>(
  (ref) {
    final productRepository = ref.watch(productsRepositoryProvider);
    return productRepository.fetchProductsList();
  },
); // Future Provider

final productProvider = StreamProvider.autoDispose.family<Product?, String>(
  (ref, id) {
    debugPrint('created product provider with id = $id');
    final productRepository = ref.watch(productsRepositoryProvider);
    return productRepository.watchProduct(id);
  },
);// Family Provider used for passing arguments in streams and similarly for futures
