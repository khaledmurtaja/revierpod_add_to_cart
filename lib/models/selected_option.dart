import 'option.dart';
import 'option_value.dart';

class SelectedOption {
  final Option option;
  final List<OptionValue> selectedValues;

  const SelectedOption({
    required this.option,
    required this.selectedValues,
  });

  double get totalPrice {
    return selectedValues.fold(0.0, (sum, value) => sum + value.price);
  }

  bool get isValid {
    if (option.isRequired && selectedValues.isEmpty) return false;
    if (option.isSingle && selectedValues.length > 1) return false;
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedOption &&
        other.option == option &&
        _listEquals(other.selectedValues, selectedValues);
  }

  @override
  int get hashCode => Object.hash(option, selectedValues);

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  @override
  String toString() => 'SelectedOption(option: ${option.name}, values: ${selectedValues.map((v) => v.name).join(', ')})';
}
