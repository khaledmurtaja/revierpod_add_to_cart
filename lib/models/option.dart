import 'package:json_annotation/json_annotation.dart';
import 'option_value.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  final String id;
  final String name;
  @JsonKey(name: 'is_required')
  final bool isRequired;
  @JsonKey(name: 'is_single')
  final bool isSingle;
  @JsonKey(name: 'is_price_determining')
  final bool isPriceDetermining;
  final List<OptionValue> values;

  const Option({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.isSingle,
    required this.isPriceDetermining,
    required this.values,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Option && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Option(id: $id, name: $name, isRequired: $isRequired, isSingle: $isSingle, isPriceDetermining: $isPriceDetermining)';
}
