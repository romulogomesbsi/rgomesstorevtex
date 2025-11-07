import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/orders_cubit.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
      body: BlocBuilder<OrdersCubit, dynamic>(
        builder: (context, state) {
          final orders = (state as dynamic).orders as List;
          if (orders.isEmpty) {
            return const Center(child: Text('Nenhum pedido'));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, i) {
              final o = orders[i];
              return ListTile(
                title: Text('Pedido ${o.id}'),
                subtitle: Text('Total: R\$ ${o.total.toStringAsFixed(2)} - ${o.createdAt.toLocal().toString()}'),
                onTap: () { /* could show details */ },
              );
            },
          );
        },
      ),
    );
  }
}
