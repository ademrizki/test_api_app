import 'package:flutter/material.dart';
import 'package:test_api_app/models/users_model.dart';
import 'package:test_api_app/services/services.dart';

class UserProvider extends ChangeNotifier {
  final ApiService service = ApiService();

  UsersModel? users;

  Future fetchUsersData() async {
    users = await service.fetchUsers();

    notifyListeners();
  }
}
