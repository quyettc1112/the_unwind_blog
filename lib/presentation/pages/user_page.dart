import 'package:clean_architecture/presentation/pages/user_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: BlocProvider(
        create: (context) => UserCubit(context.read()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Gọi fetchUsers khi nút được bấm
                  context.read<UserCubit>().fetchUsers();
                },
                child: Text('Fetch Users'),
              ),
              SizedBox(height: 20),
              Expanded(child: UserListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
