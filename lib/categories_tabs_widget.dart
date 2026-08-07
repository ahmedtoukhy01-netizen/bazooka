import 'package:flutter/material.dart';

class CategoriesTabsWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategoriesTabsWidget({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final List<String> categories = const [
    'الكل',
    'Beef Sandwich',
    'Chicken Sandwich',
    'offers',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                children: [
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSelected ? 17 : 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(height: 3, width: 45, color: Colors.yellow)
                  else
                    const SizedBox(height: 3),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}