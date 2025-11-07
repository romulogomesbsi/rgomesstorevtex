import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme.dart';
import '../../cubit/cart_cubit.dart';
import '../cart_page.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = state.totalQuantity;
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CartPage()),
                );
              },
            ),
            if (itemCount > 0) CartBadge(itemCount: itemCount),
          ],
        );
      },
    );
  }
}

class CartBadge extends StatelessWidget {
  final int itemCount;

  const CartBadge({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      top: 8,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          '$itemCount',
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textOnSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
