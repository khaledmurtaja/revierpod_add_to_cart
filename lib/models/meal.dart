import 'package:json_annotation/json_annotation.dart';
import 'option.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  final String id;
  final String name;
  final String description;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final double price;
  @JsonKey(name: 'price_before_discount')
  final double? priceBeforeDiscount;
  final List<Option> options;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.priceBeforeDiscount,
    required this.options,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Meal && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Meal(id: $id, name: $name, price: $price)';
}
