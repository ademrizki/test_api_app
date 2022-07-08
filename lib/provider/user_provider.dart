import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_api_app/models/users_model.dart';
import 'package:test_api_app/services/services.dart';
import 'package:test_api_app/utils/state/finite_state.dart';

class UserProvider extends ChangeNotifier {
  final ApiService service = ApiService();

  UsersModel? users;

  MyState myState = MyState.loading;

  Future fetchUsersData() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      users = await service.fetchUsers();

      myState = MyState.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        /// If want to check status code from service error
        e.response!.statusCode;
      }

      myState = MyState.failed;
      notifyListeners();
    }
  }
}
