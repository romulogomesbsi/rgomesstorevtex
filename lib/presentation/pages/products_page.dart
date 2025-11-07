import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme.dart';
import '../../presentation/cubit/products_cubit.dart';
import '../../presentation/cubit/products_state.dart';
import '../../presentation/cubit/cart_cubit.dart';
import 'widgets/widgets.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsCubit>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: const CartFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'RD Store',
        style: AppTypography.brandTitle,
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: 0,
      actions: const [
        CartIcon(),
        SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundDecoration,
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const LoadingWidget();
          } else if (state is ProductsLoaded) {
            return _buildProductsContent(context, state);
          } else if (state is ProductsError) {
            return ProductsErrorWidget(
              state: state,
              cubit: context.read<ProductsCubit>(),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildProductsContent(BuildContext context, ProductsLoaded state) {
    final cubit = context.read<ProductsCubit>();
    final cartCubit = context.read<CartCubit>();

    return Column(
      children: [
        if (state.availableCategories.isNotEmpty)
          CategoryFilters(state: state, cubit: cubit),
        Expanded(
          child: ProductsGrid(
            state: state,
            cartCubit: cartCubit,
            productsCubit: cubit,
          ),
        ),
      ],
    );
  }
}
