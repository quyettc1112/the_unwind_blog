import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_unwind_blog/common/widgets/appbar/app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: 'My Feed',
        showBackButton: true,  // Hiển thị nút back
        showNotificationsIcon: true,  // Hiển thị biểu tượng thông báo
        showEditIcon: true,  // Hiển thị biểu tượng chỉnh sửa
        onBackPressed: () {
          // Xử lý sự kiện khi nhấn nút back
          print("Back clicked");
        },
        onNotificationsPressed: () {
          // Xử lý sự kiện khi nhấn vào biểu tượng thông báo
          print("Notifications clicked");
        },
        onEditPressed: () {
          // Xử lý sự kiện khi nhấn vào biểu tượng chỉnh sửa
          print("Edit clicked");
        },
      ),
      body: Center(child: Text("Welcome to My Feed")),
    );
  }
}