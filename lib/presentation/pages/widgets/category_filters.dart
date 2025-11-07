import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../../cubit/products_cubit.dart';
import '../../cubit/products_state.dart';

class CategoryFilters extends StatelessWidget {
  final ProductsLoaded state;
  final ProductsCubit cubit;

  const CategoryFilters({
    super.key,
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CategoryChip(
            label: 'Todos',
            value: '',
            selectedCategory: state.selectedCategory,
            cubit: cubit,
          ),
          const SizedBox(width: 8),
          ...state.availableCategories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CategoryChip(
                label: category,
                value: category,
                selectedCategory: state.selectedCategory,
                cubit: cubit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final String value;
  final String selectedCategory;
  final ProductsCubit cubit;

  const CategoryChip({
    super.key,
    required this.label,
    required this.value,
    required this.selectedCategory,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedCategory == value;

    return FilterChip(
      label: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: isSelected ? AppColors.textOnPrimary : AppColors.primary,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => cubit.filterByCategory(value),
      selectedColor: AppColors.primary,
      checkmarkColor: AppColors.textOnPrimary,
      backgroundColor: AppColors.surface,
      side: BorderSide(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
