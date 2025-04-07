import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/appbar/app_bar.dart';

class MarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Mark'),
      ),
      body: Center(
        child: Text("Welcome to Mark Screen"),
      ),
    );
  }
}