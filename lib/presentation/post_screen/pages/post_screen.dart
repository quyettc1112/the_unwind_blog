import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/tabbar/circle_tab_indicator.dart';
import '../../../core/config/theme/app_colors.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text('Post Screen')),
      body: Text('aaa'),
    );
  }
}


