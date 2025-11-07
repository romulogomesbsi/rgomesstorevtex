import '../../domain/entities/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final List<String> availableCategories;
  final String selectedCategory;

  ProductsLoaded(this.products,
      [this.availableCategories = const [], this.selectedCategory = '']);
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}
