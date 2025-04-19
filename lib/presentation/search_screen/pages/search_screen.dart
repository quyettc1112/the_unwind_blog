import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/presentation/home_screen/bloc/blog_cubit.dart';

import '../../../domain/entities/blog_unwind_entity.dart';
import '../../../untils/logger_settigns.dart';
import '../../../untils/resource.dart';
import '../../home_screen/bloc/blog_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
