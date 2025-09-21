// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionValue _$OptionValueFromJson(Map<String, dynamic> json) => OptionValue(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$OptionValueToJson(OptionValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };
