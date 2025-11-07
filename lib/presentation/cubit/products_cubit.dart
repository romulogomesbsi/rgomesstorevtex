import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/entities/product.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  List<Product> _allProducts = [];
  String _selectedCategory = '';

  ProductsCubit(this.getProductsUseCase) : super(ProductsInitial());

  Future<void> loadProducts() async {
    emit(ProductsLoading());
    try {
      _allProducts = await getProductsUseCase();
      emit(ProductsLoaded(_allProducts, getAvailableCategories()));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    final filteredProducts = category.isEmpty
        ? _allProducts
        : _allProducts
            .where(
                (p) => p.mainCategory.toLowerCase() == category.toLowerCase())
            .toList();

    emit(ProductsLoaded(
        filteredProducts, getAvailableCategories(), _selectedCategory));
  }

  List<String> getAvailableCategories() {
    final categories = <String>{};
    for (final product in _allProducts) {
      final mainCategory = product.mainCategory;
      if (mainCategory.isNotEmpty) {
        categories.add(mainCategory);
      }
    }
    return categories.toList()..sort();
  }

  String get selectedCategory => _selectedCategory;
}
