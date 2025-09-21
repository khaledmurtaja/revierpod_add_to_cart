// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  imageUrl: json['image_url'] as String,
  price: (json['price'] as num).toDouble(),
  priceBeforeDiscount: (json['price_before_discount'] as num?)?.toDouble(),
  options: (json['options'] as List<dynamic>)
      .map((e) => Option.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'image_url': instance.imageUrl,
  'price': instance.price,
  'price_before_discount': instance.priceBeforeDiscount,
  'options': instance.options,
};
