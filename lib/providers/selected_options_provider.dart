import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';
import '../models/selected_option.dart';
import '../models/option_value.dart';

final selectedMealProvider = StateProvider<Meal?>((ref) => null);

final selectedOptionsProvider = StateNotifierProvider<SelectedOptionsNotifier, Map<String, SelectedOption>>((ref) {
  return SelectedOptionsNotifier();
});

class SelectedOptionsNotifier extends StateNotifier<Map<String, SelectedOption>> {
  SelectedOptionsNotifier() : super({});

  void initializeOptions(Meal meal) {
    final options = <String, SelectedOption>{};
    
    for (final option in meal.options) {
      if (option.isRequired && option.isSingle) {
        // Auto-select first value for required single options
        final firstValue = option.values.first;
        options[option.id] = SelectedOption(
          option: option,
          selectedValues: [firstValue],
        );
      } else {
        // Initialize with empty selection
        options[option.id] = SelectedOption(
          option: option,
          selectedValues: [],
        );
      }
    }
    
    state = options;
  }

  void selectValue(String optionId, OptionValue value) {
    final currentOptions = Map<String, SelectedOption>.from(state);
    final currentOption = currentOptions[optionId];
    
    if (currentOption == null) return;
    
    if (currentOption.option.isSingle) {
      // Single selection - replace current selection
      currentOptions[optionId] = SelectedOption(
        option: currentOption.option,
        selectedValues: [value],
      );
    } else {
      // Multiple selection - toggle value
      final currentValues = List<OptionValue>.from(currentOption.selectedValues);
      if (currentValues.contains(value)) {
        currentValues.remove(value);
      } else {
        currentValues.add(value);
      }
      
      currentOptions[optionId] = SelectedOption(
        option: currentOption.option,
        selectedValues: currentValues,
      );
    }
    
    state = currentOptions;
  }

  void clearSelection() {
    state = {};
  }

  List<SelectedOption> getSelectedOptions() {
    return state.values.where((option) => option.selectedValues.isNotEmpty).toList();
  }

  bool isValidSelection() {
    return state.values.every((option) => option.isValid);
  }

  double calculateTotalPrice(Meal meal) {
    final basePrice = _getBasePrice(meal);
    final optionsPrice = state.values.fold(0.0, (sum, option) => sum + option.totalPrice);
    return basePrice + optionsPrice;
  }

  double _getBasePrice(Meal meal) {
    final priceDeterminingOption = state.values
        .where((option) => option.option.isPriceDetermining)
        .firstOrNull;
    
    if (priceDeterminingOption != null && priceDeterminingOption.selectedValues.isNotEmpty) {
      return priceDeterminingOption.selectedValues.first.price;
    }
    
    return meal.price;
  }
}
