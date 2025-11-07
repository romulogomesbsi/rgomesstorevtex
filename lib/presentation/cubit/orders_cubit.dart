import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/order.dart';
import 'package:uuid/uuid.dart';

class OrdersState {
  final List<Order> orders;
  OrdersState(this.orders);
}

class OrdersCubit extends Cubit<OrdersState> {
  static const _boxName = 'ordersBox';
  static const _key = 'orders_list';

  OrdersCubit() : super(OrdersState([])) {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box(_boxName);
    final raw = box.get(_key);
    if (raw != null) {
      try {
        final List data = raw as List<dynamic>;
        final items = data.map((e) => Order.fromJson(Map<String, dynamic>.from(e))).toList();
        emit(OrdersState(items));
      } catch (_) {}
    }
  }

  Future<void> _save(List<Order> items) async {
    final box = Hive.box(_boxName);
    final encoded = items.map((e) => e.toJson()).toList();
    await box.put(_key, encoded);
  }

  Future<void> addOrder(List<Map<String, dynamic>> items, double total) async {
    final id = Uuid().v4();
    final order = Order(id: id, items: items, total: total, createdAt: DateTime.now());
    final updated = List<Order>.from(state.orders)..add(order);
    emit(OrdersState(updated));
    await _save(updated);
  }
}
