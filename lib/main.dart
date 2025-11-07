import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/theme.dart';
import 'core/http_client.dart';
import 'data/datasources/vtex_remote_datasource.dart';
import 'data/repositories/vtex_repository_impl.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'presentation/cubit/products_cubit.dart';
import 'presentation/cubit/cart_cubit.dart';
import 'presentation/cubit/orders_cubit.dart';
import 'presentation/pages/products_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cartBox');
  await Hive.openBox('ordersBox');

  final client = HttpClient();
  final datasource = VtexRemoteDataSource(client);
  final repository = VtexRepositoryImpl(datasource);
  final usecase = GetProductsUseCase(repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetProductsUseCase usecase;

  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsCubit(usecase)),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => OrdersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RD Store',
        theme: AppTheme.lightTheme,
        home: const ProductsPage(),
      ),
    );
  }
}
