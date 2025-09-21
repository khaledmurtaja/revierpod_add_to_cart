import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/selected_options_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/common/option_selector.dart';
import '../widgets/common/quantity_selector.dart';
import '../models/meal.dart';

class AddToCartModal extends ConsumerStatefulWidget {
  final dynamic meal;

  const AddToCartModal({super.key, required this.meal});

  @override
  ConsumerState<AddToCartModal> createState() => _AddToCartModalState();
}

class _AddToCartModalState extends ConsumerState<AddToCartModal> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedMealProvider.notifier).state = widget.meal;
      ref.read(selectedOptionsProvider.notifier).initializeOptions(widget.meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal as Meal;
    final selectedOptions = ref.watch(selectedOptionsProvider);
    final totalPrice = ref.watch(selectedOptionsProvider.notifier).calculateTotalPrice(meal);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(meal, totalPrice),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMealImage(meal),
                  const SizedBox(height: 20),
                  _buildOptions(selectedOptions),
                ],
              ),
            ),
          ),
          _buildAddToCartButton(meal, totalPrice),
        ],
      ),
    );
  }

  Widget _buildHeader(Meal meal, double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    QuantitySelector(
                      initialQuantity: _quantity,
                      onQuantityChanged: (quantity) {
                        setState(() {
                          _quantity = quantity;
                        });
                      },
                    ),
                    const Spacer(),
                    Text(
                      '${(totalPrice * _quantity).toStringAsFixed(2)} \$',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealImage(Meal meal) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 200,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: meal.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.restaurant,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(Map<String, dynamic> selectedOptions) {
    final meal = widget.meal as Meal;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: meal.options.map((option) {
        final selectedOption = selectedOptions[option.id];
        if (selectedOption == null) return const SizedBox.shrink();
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: OptionSelector(
            option: option,
            selectedValues: selectedOption.selectedValues,
            onValueSelected: (value) {
              ref.read(selectedOptionsProvider.notifier).selectValue(option.id, value);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddToCartButton(Meal meal, double totalPrice) {
    final isValid = ref.watch(selectedOptionsProvider.notifier).isValidSelection();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: isValid ? () => _addToCart(meal) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Add To Cart - ${(totalPrice * _quantity).toStringAsFixed(2)} \$',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _addToCart(Meal meal) {
    final selectedOptions = ref.read(selectedOptionsProvider.notifier).getSelectedOptions();
    
    ref.read(cartProvider.notifier).addItem(
      meal,
      selectedOptions,
      quantity: _quantity,
    );
    
    Navigator.of(context).pop();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${meal.name} added to cart'),
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
