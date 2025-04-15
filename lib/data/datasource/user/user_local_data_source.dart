import '../../../domain/entities/user_entity.dart';

import 'package:hive/hive.dart';
import '../../models/user_model.dart';

import 'package:hive/hive.dart';
import '../../models/user_model.dart';

abstract interface class UserLocalDataSource {
  Future<void> saveUsers(List<UserModel> users);
  List<UserModel> loadUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;

  UserLocalDataSourceImpl(this.box);

  @override
  List<UserModel> loadUsers() {
    List<UserModel> users = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        final raw = box.get(i.toString());
        if (raw != null) {
          users.add(UserModel.fromJson(Map<String, dynamic>.from(raw)));
        }
      }
    });
    return users;
  }

  @override
  Future<void> saveUsers(List<UserModel> users) async {
    box.clear(); // Xóa hết trước khi ghi mới
    await box.write(() {
      for (int i = 0; i < users.length; i++) {
        box.put(i.toString(), users[i].toJson());
      }
    });
  }
}
