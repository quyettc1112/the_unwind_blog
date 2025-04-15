import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/tabbar/custom_tabbar.dart';
import '../../../core/base_state/base_list_cubit.dart';
import '../../../core/base_state/base_list_state.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../domain/entities/user_entity.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabContoller;


  @override
  void initState() {
    tabContoller = new TabController(vsync: this, length: 3);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<BaseCubit<List<BlogEntity>>>();

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<BaseCubit<List<BlogEntity>>, BaseState<List<BlogEntity>>>(
        builder: (context, state) {
          if (state is LoadingState<List<BlogEntity>>) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState<List<BlogEntity>>) {
            final blogs = state.data;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(blogs[index].title),
                );
              },
            );
          } else if (state is ErrorState<List<BlogEntity>>) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Press button to load users.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => userCubit.loadData(), // 👈 loadData của BaseCubit
        child: const Icon(Icons.refresh),
      ),
    );
  }

}

