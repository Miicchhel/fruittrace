import 'package:flutter/material.dart';
import 'package:fruittrace/src/config/custom_colors.dart';

class CategoryTitle extends StatelessWidget {

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryTitle({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: isSelected ? CustomColors.customSwatchColor: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
              fontSize: isSelected ? 16.0 : 14.0,
            ),
          ),
        ),
      ),
    );
  }
}