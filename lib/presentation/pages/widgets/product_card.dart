import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../../domain/entities/product.dart';
import '../../cubit/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit;

  const ProductCard({
    super.key,
    required this.product,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: AppTheme.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: _ProductImage(product: product),
            ),
            Expanded(
              flex: 3,
              child: _ProductInfo(product: product, cartCubit: cartCubit),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final Product product;

  const _ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: AppColors.surfaceVariant,
            child: product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
                  )
                : const _ImagePlaceholder(),
          ),
        ),
        if (product.mainCategory.isNotEmpty)
          _CategoryTag(category: product.mainCategory),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.image_outlined,
        size: 50,
        color: AppColors.grey500,
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String category;

  const _CategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.primaryWithOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          category,
          style: AppTypography.categoryTag,
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit;

  const _ProductInfo({required this.product, required this.cartCubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (product.brand.isNotEmpty) ...[
            _BrandText(brand: product.brand),
            const SizedBox(height: 2),
          ],
          _ProductTitle(title: product.displayTitle),
          if (product.description.isNotEmpty) ...[
            const SizedBox(height: 2),
            _ProductDescription(description: product.description),
          ],
          const Spacer(),
          _ProductPrice(price: product.price),
          const SizedBox(height: 6),
          _AddToCartButton(product: product, cartCubit: cartCubit),
        ],
      ),
    );
  }
}

class _BrandText extends StatelessWidget {
  final String brand;

  const _BrandText({required this.brand});

  @override
  Widget build(BuildContext context) {
    return Text(
      brand.toUpperCase(),
      style: AppTypography.brandSubtitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ProductTitle extends StatelessWidget {
  final String title;

  const _ProductTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Text(
        title,
        style: AppTypography.productTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final String description;

  const _ProductDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Text(
        description,
        style: AppTypography.productDescription,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final double price;

  const _ProductPrice({required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      'R\$ ${price.toStringAsFixed(2)}',
      style: AppTypography.priceSmall,
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit;

  const _AddToCartButton({required this.product, required this.cartCubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 28,
      child: ElevatedButton(
        onPressed: () => cartCubit.addItem(product),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: Text(
          'Adicionar',
          style: AppTypography.buttonSmall,
        ),
      ),
    );
  }
}
