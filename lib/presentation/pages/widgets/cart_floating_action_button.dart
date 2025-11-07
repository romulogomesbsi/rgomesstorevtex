import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme.dart';
import '../../cubit/cart_cubit.dart';
import '../cart_page.dart';

class CartFloatingActionButton extends StatelessWidget {
  const CartFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final total = state.total;
        final itemCount = state.totalQuantity;

        if (itemCount == 0) return const SizedBox.shrink();

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [AppTheme.elevationShadow],
          ),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const CartPage()));
            },
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 0,
            label: Text(
              'Ver Carrinho • R\$ ${total.toStringAsFixed(2)}',
              style: AppTypography.button,
            ),
            icon: _FloatingActionButtonIcon(itemCount: itemCount),
          ),
        );
      },
    );
  }
}

class _FloatingActionButtonIcon extends StatelessWidget {
  final int itemCount;

  const _FloatingActionButtonIcon({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.shopping_cart, size: 24),
        if (itemCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$itemCount',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textOnSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
