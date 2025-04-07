import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                leading: Image.network(user.img),
              );
            },
          );
        } else {
          return Center(child: Text("Press the button to fetch users"));
        }
      },
    );
  }
}
