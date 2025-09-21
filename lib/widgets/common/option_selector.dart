import 'package:flutter/material.dart';
import '../../models/option.dart';
import '../../models/option_value.dart';

class OptionSelector extends StatelessWidget {
  final Option option;
  final List<OptionValue> selectedValues;
  final ValueChanged<OptionValue> onValueSelected;

  const OptionSelector({
    super.key,
    required this.option,
    required this.selectedValues,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${option.name}:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (option.isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '(required)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        if (option.isSingle) _buildRadioOptions() else _buildCheckboxOptions(),
      ],
    );
  }

  Widget _buildRadioOptions() {
    return Column(
      children: option.values.map((value) {
        final isSelected = selectedValues.contains(value);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => onValueSelected(value),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.purple : Colors.grey[300]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? Colors.purple.withValues(alpha: 0.1) : Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.purple : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected ? Colors.purple : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.purple : Colors.black87,
                      ),
                    ),
                  ),
                  if (value.price > 0)
                    Text(
                      '${value.price.toStringAsFixed(2)} \$',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.purple : Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCheckboxOptions() {
    return Column(
      children: option.values.map((value) {
        final isSelected = selectedValues.contains(value);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => onValueSelected(value),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.purple : Colors.grey[300]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? Colors.purple.withValues(alpha: 0.1) : Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected ? Colors.purple : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected ? Colors.purple : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      value.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.purple : Colors.black87,
                      ),
                    ),
                  ),
                  if (value.price > 0)
                    Text(
                      '${value.price.toStringAsFixed(2)} \$',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.purple : Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
