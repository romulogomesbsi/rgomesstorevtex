import 'package:flutter/material.dart';
import '../../cubit/products_cubit.dart';
import '../../cubit/products_state.dart';
import '../../cubit/cart_cubit.dart';
import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final ProductsLoaded state;
  final CartCubit cartCubit;
  final ProductsCubit productsCubit;

  const ProductsGrid({
    super.key,
    required this.state,
    required this.cartCubit,
    required this.productsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: productsCubit.loadProducts,
      color: const Color(0xFF4A90E2),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: state.products.length,
        itemBuilder: (_, i) {
          final product = state.products[i];
          return ProductCard(
            product: product,
            cartCubit: cartCubit,
          );
        },
      ),
    );
  }
}
