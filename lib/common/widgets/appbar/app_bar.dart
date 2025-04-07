
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_colors.dart';

import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackButton;
  final bool showNotificationsIcon;
  final bool showEditIcon;
  final Function()? onBackPressed;
  final Function()? onNotificationsPressed;
  final Function()? onEditPressed;

  const BasicAppBar({
    required this.title,
    this.showBackButton = true,
    this.showNotificationsIcon = true,
    this.showEditIcon = true,
    this.onBackPressed,
    this.onNotificationsPressed,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
        onPressed: onBackPressed ??
                () {
              Navigator.pop(context);
            },
      )
          : null,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
      title: title ?? Text(''),
      actions: [
        if (showEditIcon)
          IconButton(
            icon: Icon(Icons.edit, color: colorScheme.onSurface),
            onPressed: onEditPressed,
          ),
        if (showNotificationsIcon)
          IconButton(
            icon: Icon(Icons.notifications, color: colorScheme.onSurface),
            onPressed: onNotificationsPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
