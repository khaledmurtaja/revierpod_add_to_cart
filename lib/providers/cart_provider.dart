import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/cart_repository.dart';
import '../models/cart.dart';
import '../models/meal.dart';
import '../models/selected_option.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  final repository = ref.read(cartRepositoryProvider);
  return CartNotifier(repository);
});

class CartNotifier extends StateNotifier<Cart> {
  final CartRepository _repository;

  CartNotifier(this._repository) : super(_repository.cart);

  void addItem(Meal meal, List<SelectedOption> selectedOptions, {int quantity = 1}) {
    _repository.addItem(meal, selectedOptions, quantity: quantity);
    state = _repository.cart;
  }

  void updateItemQuantity(String itemId, int quantity) {
    _repository.updateItemQuantity(itemId, quantity);
    state = _repository.cart;
  }

  void removeItem(String itemId) {
    _repository.removeItem(itemId);
    state = _repository.cart;
  }

  void clearCart() {
    _repository.clearCart();
    state = _repository.cart;
  }
}
