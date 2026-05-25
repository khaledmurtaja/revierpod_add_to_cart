// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
  id: json['id'] as String,
  name: json['name'] as String,
  isRequired: json['is_required'] as bool,
  isSingle: json['is_single'] as bool,
  isPriceDetermining: json['is_price_determining'] as bool,
  values: (json['values'] as List<dynamic>)
      .map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_required': instance.isRequired,
  'is_single': instance.isSingle,
  'is_price_determining': instance.isPriceDetermining,
  'values': instance.values,
};
