import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../bloc/theme_cubit.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackButton;
  final bool showNotificationsIcon;
  final bool showEditIcon;
  final bool showThemeIcon;
  final Function()? onBackPressed;
  final Function()? onNotificationsPressed;
  final Function()? onEditPressed;

  const BasicAppBar({
    required this.title,
    this.showBackButton = false,
    this.showNotificationsIcon = false,
    this.showEditIcon = false,
    this.showThemeIcon = false,
    this.onBackPressed,
    this.onNotificationsPressed,
    this.onEditPressed,
  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final appBarBackgroundColor = context.isDarkMode
        ? AppColors.background_black  // Light theme primary color
        : AppColors.white ;  // Dark theme secondary color

    return AppBar(
      backgroundColor: appBarBackgroundColor,
      leading:
          showBackButton
              ? IconButton(
                icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                onPressed:
                    onBackPressed ??
                    () {
                      Navigator.pop(context);
                    },
              )
              : null,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      title: title ?? Text(''),
      actions: [
        if (showEditIcon)
          IconButton(
            icon: Icon(Icons.edit_outlined, color: colorScheme.onSurface),
            onPressed: onEditPressed,
          ),
        if (showNotificationsIcon)
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: colorScheme.onSurface),
            onPressed: onNotificationsPressed,
          ),
        if (showThemeIcon)
          IconButton(
            icon: Icon(
              context.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              // Toggle theme mode when the button is pressed
              ThemeMode newThemeMode =
                  context.isDarkMode ? ThemeMode.light : ThemeMode.dark;
              context.read<ThemeCubit>().updateTheme(newThemeMode);
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
