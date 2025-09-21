import 'package:json_annotation/json_annotation.dart';

part 'option_value.g.dart';

@JsonSerializable()
class OptionValue {
  final String id;
  final String name;
  final double price;

  const OptionValue({
    required this.id,
    required this.name,
    required this.price,
  });

  factory OptionValue.fromJson(Map<String, dynamic> json) =>
      _$OptionValueFromJson(json);

  Map<String, dynamic> toJson() => _$OptionValueToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OptionValue && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'OptionValue(id: $id, name: $name, price: $price)';
}
