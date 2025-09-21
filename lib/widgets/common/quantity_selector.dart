import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;
  final int minQuantity;
  final int maxQuantity;
  final bool isColumn; // 👈 added

  const QuantitySelector({
    super.key,
    required this.initialQuantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    this.isColumn = false, // 👈 default value
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector>
    with TickerProviderStateMixin {
  late int _quantity;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeQuantity(int delta) {
    final newQuantity = _quantity + delta;
    if (newQuantity >= widget.minQuantity && newQuantity <= widget.maxQuantity) {
      setState(() {
        _quantity = newQuantity;
      });
      widget.onQuantityChanged(_quantity);
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = [
      _buildButton(
        icon: "assets/removeButton.svg",
        onPressed: _quantity > widget.minQuantity ? () => _changeQuantity(-1) : null,
      ),
      widget.isColumn ? const SizedBox(height: 16) : const SizedBox(width: 16),
      AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      widget.isColumn ? const SizedBox(height: 16) : const SizedBox(width: 16),
      _buildButton(
        icon: "assets/addButton.svg",
        onPressed: _quantity < widget.maxQuantity ? () => _changeQuantity(1) : null,
      ),
    ];

    // 👇 choose Row or Column dynamically
    return widget.isColumn
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildButton({
    required String icon,
    required VoidCallback? onPressed,
  }) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: onPressed != null ? Colors.purple : Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onPressed,
                child: SvgPicture.asset(icon),
              ),
            ),
          ),
        );
      },
    );
  }
}
