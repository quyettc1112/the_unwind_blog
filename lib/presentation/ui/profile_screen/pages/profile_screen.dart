import 'package:flutter/material.dart';
import 'package:the_unwind_blog/common/widgets/appbar/app_bar.dart';

import '../../../../common/bloc/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        showThemeIcon: true,
      ),
      body: Center(
        child: Text("Welcome to Profile Screen"),
      ),
    );
  }
}