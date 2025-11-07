import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
      );

  double get totalPrice => product.price * quantity;
}

class CartState {
  final List<CartItem> cartItems;
  CartState(this.cartItems);

  List<Product> get items => cartItems.map((e) => e.product).toList();
  double get total => cartItems.fold(0.0, (s, item) => s + item.totalPrice);
  int get totalQuantity => cartItems.fold(0, (s, item) => s + item.quantity);
}

class CartCubit extends Cubit<CartState> {
  static const _boxName = 'cartBox';
  static const _key = 'cart_items';
  CartCubit() : super(CartState([])) {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box(_boxName);
    final raw = box.get(_key);
    if (raw != null) {
      try {
        final List data = raw as List<dynamic>;
        final items = data
            .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        emit(CartState(items));
      } catch (_) {}
    }
  }

  Future<void> _save(List<CartItem> items) async {
    final box = Hive.box(_boxName);
    final encoded = items.map((e) => e.toJson()).toList();
    await box.put(_key, encoded);
  }

  void addItem(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      cartItems[existingIndex] = cartItems[existingIndex]
          .copyWith(quantity: cartItems[existingIndex].quantity + 1);
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    emit(CartState(cartItems));
    _save(cartItems);
  }

  void removeItem(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    cartItems.removeWhere((item) => item.product.id == product.id);
    emit(CartState(cartItems));
    _save(cartItems);
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeItem(product);
      return;
    }

    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      cartItems[existingIndex] =
          cartItems[existingIndex].copyWith(quantity: quantity);
      emit(CartState(cartItems));
      _save(cartItems);
    }
  }

  void incrementQuantity(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      cartItems[existingIndex] = cartItems[existingIndex]
          .copyWith(quantity: cartItems[existingIndex].quantity + 1);
      emit(CartState(cartItems));
      _save(cartItems);
    }
  }

  void decrementQuantity(Product product) {
    final cartItems = List<CartItem>.from(state.cartItems);
    final existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      if (cartItems[existingIndex].quantity > 1) {
        cartItems[existingIndex] = cartItems[existingIndex]
            .copyWith(quantity: cartItems[existingIndex].quantity - 1);
        emit(CartState(cartItems));
        _save(cartItems);
      } else {
        removeItem(product);
      }
    }
  }

  void clear() {
    emit(CartState([]));
    _save([]);
  }
}
