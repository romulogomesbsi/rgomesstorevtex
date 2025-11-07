import '../entities/product.dart';

abstract class VtexRepository {
  Future<List<Product>> getProducts();
}
