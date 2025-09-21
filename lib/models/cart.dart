import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  const Cart({required this.items});

  double get totalPrice {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  Cart addItem(CartItem newItem) {
    final existingItemIndex = items.indexWhere((item) => item == newItem);
    
    if (existingItemIndex != -1) {
      // Update quantity of existing item
      final existingItem = items[existingItemIndex];
      final updatedItem = CartItem(
        id: existingItem.id,
        meal: existingItem.meal,
        selectedOptions: existingItem.selectedOptions,
        quantity: existingItem.quantity + newItem.quantity,
      );
      
      final updatedItems = List<CartItem>.from(items);
      updatedItems[existingItemIndex] = updatedItem;
      return Cart(items: updatedItems);
    } else {
      // Add new item
      return Cart(items: [...items, newItem]);
    }
  }

  Cart updateItemQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      return removeItem(itemId);
    }
    
    final itemIndex = items.indexWhere((item) => item.id == itemId);
    if (itemIndex == -1) return this;
    
    final item = items[itemIndex];
    final updatedItem = CartItem(
      id: item.id,
      meal: item.meal,
      selectedOptions: item.selectedOptions,
      quantity: newQuantity,
    );
    
    final updatedItems = List<CartItem>.from(items);
    updatedItems[itemIndex] = updatedItem;
    return Cart(items: updatedItems);
  }

  Cart removeItem(String itemId) {
    final updatedItems = items.where((item) => item.id != itemId).toList();
    return Cart(items: updatedItems);
  }

  Cart clear() {
    return const Cart(items: []);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cart && _listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  @override
  String toString() => 'Cart(items: ${items.length}, totalPrice: $totalPrice)';
}
