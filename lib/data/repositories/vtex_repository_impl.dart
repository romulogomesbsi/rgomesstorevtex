import '../../domain/entities/product.dart';
import '../../domain/repositories/vtex_repository.dart';
import '../datasources/vtex_remote_datasource.dart';

class VtexRepositoryImpl implements VtexRepository {
  final VtexRemoteDataSource remoteDataSource;

  VtexRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.fetchProducts();
  }
}
