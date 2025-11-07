import '../entities/product.dart';
import '../repositories/vtex_repository.dart';

class GetProductsUseCase {
  final VtexRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
