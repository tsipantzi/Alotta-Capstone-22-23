import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class FoodCategoryBubble extends StatefulWidget {
  final String category;
  final ValueChanged<MapEntry<String, bool>> onSelected;
  bool isSelected = false;
  FoodCategoryBubble(
      {super.key, required this.category, required this.onSelected});

  @override
  State<FoodCategoryBubble> createState() => _FoodCategoryBubbleState();
}

class _FoodCategoryBubbleState extends State<FoodCategoryBubble> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        widget.isSelected = !widget.isSelected;
        widget.onSelected(MapEntry(widget.category, widget.isSelected));
      }),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                widget.isSelected ? primaryGreen : primaryOrangeMaterialColor,
            width: 2,
          ),
          color: primaryCream,
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Text(
          widget.category,
          style: TextStyle(
            color:
                widget.isSelected ? primaryGreen : primaryOrangeMaterialColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
