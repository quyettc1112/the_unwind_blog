import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/presentation/home_screen/bloc/blog_cubit.dart';

import '../../../untils/logger_settigns.dart';
import '../../home_screen/bloc/blog_state.dart';
import '../../state_renderer/state_render_impl.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<BlogCubit>().getBlogs();

      final currentState = context.read<BlogCubit>().state;

      if (currentState is ContentState) {
        print("✅ getBlogs() đã gọi xong.");
        print("📦 API dữ liệu trả về:");
        for (var blog in currentState.data) {
          print("📄 Blog: ${blog.title} | ${blog.createdAt}");
        }
      } else if (currentState is ErrorState) {
        print("❌ Lỗi khi gọi API: ${currentState.message}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }



  /*@override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() {
    context.read<BlogCubit>().getBlogs();
  }
*/
  /*@override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogCubit, FlowState>(listener: (context, state) {
      if (state is BlogLoadingState) {
        print("LOADİNG");
      } else if (state is BlogLoadedState) {
        print("LOADED");
      } else if (state is BlogErrorState) {
        print("WTF: ${state.getMessage()}");
      }
      print("XXX STATE:" + state.toString());
    }, builder: (context, state) {
      return Scaffold(
      );
    });
  }*/

}

Widget _getContent(BuildContext context, FlowState state) {
  if (state is ContentState) {
    logger.i("ALOO");
    logger.i(state.data);

    return ListView.builder(
        itemBuilder: (context, index) {
          if (state is ContentState) {
            final user = state.data[index];
            return ListTile(
              leading: Image.network(user.avatar.toString()),
              title: Text(user.name.toString()),
              subtitle: Text(user.createdAt!.substring(10).toString()),
            );
          }
        },
        itemCount: state is ContentState ? state.data.length : 0);
  }
  return Container();
}

