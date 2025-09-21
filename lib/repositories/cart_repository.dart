import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/meal.dart';
import '../models/selected_option.dart';

class CartRepository {
  Cart _cart = const Cart(items: []);

  Cart get cart => _cart;

  void addItem(Meal meal, List<SelectedOption> selectedOptions, {int quantity = 1}) {
    final cartItem = CartItem(
      id: _generateItemId(meal, selectedOptions),
      meal: meal,
      selectedOptions: selectedOptions,
      quantity: quantity,
    );
    
    _cart = _cart.addItem(cartItem);
  }

  void updateItemQuantity(String itemId, int quantity) {
    _cart = _cart.updateItemQuantity(itemId, quantity);
  }

  void removeItem(String itemId) {
    _cart = _cart.removeItem(itemId);
  }

  void clearCart() {
    _cart = _cart.clear();
  }

  String _generateItemId(Meal meal, List<SelectedOption> selectedOptions) {
    final optionsString = selectedOptions
        .map((option) => '${option.option.id}:${option.selectedValues.map((v) => v.id).join(',')}')
        .join('|');
    return '${meal.id}_$optionsString';
  }
}
