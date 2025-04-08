import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length + 1, // +1 for "All" chip
        itemBuilder: (context, index) {
          // First chip is "All"
          if (index == 0) {
            final isSelected = selectedCategory.isEmpty;
            return _buildChip(
              context: context,
              label: 'All',
              isSelected: isSelected,
              onTap: () => onCategorySelected(''),
              colorScheme: colorScheme,
            );
          }
          
          final category = categories[index - 1];
          final isSelected = selectedCategory == category;
          
          return _buildChip(
            context: context,
            label: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category),
            colorScheme: colorScheme,
          );
        },
      ),
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.primary : colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.transparent,
                width: 0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add icon for selected chip
                if (isSelected) ...[  
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 4),
                ],
                
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}