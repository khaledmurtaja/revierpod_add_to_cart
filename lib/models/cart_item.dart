import 'meal.dart';
import 'selected_option.dart';

class CartItem {
  final String id;
  final Meal meal;
  final List<SelectedOption> selectedOptions;
  final int quantity;

  const CartItem({
    required this.id,
    required this.meal,
    required this.selectedOptions,
    required this.quantity,
  });

  double get basePrice {
    final priceDeterminingOption = selectedOptions
        .where((option) => option.option.isPriceDetermining)
        .firstOrNull;
    
    if (priceDeterminingOption != null && priceDeterminingOption.selectedValues.isNotEmpty) {
      return priceDeterminingOption.selectedValues.first.price;
    }
    
    return meal.price;
  }

  double get totalPrice {
    final basePrice = this.basePrice;
    final optionsPrice = selectedOptions.fold(0.0, (sum, option) => sum + option.totalPrice);
    return (basePrice + optionsPrice) * quantity;
  }

  String get displayName {
    final priceDeterminingValue = selectedOptions
        .where((option) => option.option.isPriceDetermining)
        .firstOrNull
        ?.selectedValues
        .firstOrNull;
    
    if (priceDeterminingValue != null) {
      return '${meal.name} (${priceDeterminingValue.name})';
    }
    
    return meal.name;
  }

  String get optionsDescription {
    final descriptions = <String>[];
    
    for (final selectedOption in selectedOptions) {
      if (selectedOption.selectedValues.isNotEmpty) {
        final valueNames = selectedOption.selectedValues.map((v) => v.name).join(', ');
        descriptions.add('${selectedOption.option.name}: $valueNames');
      }
    }
    
    return descriptions.join(', ');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.meal == meal &&
        _listEquals(other.selectedOptions, selectedOptions);
  }

  @override
  int get hashCode => Object.hash(meal, selectedOptions);

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  @override
  String toString() => 'CartItem(id: $id, meal: ${meal.name}, quantity: $quantity, totalPrice: $totalPrice)';
}
