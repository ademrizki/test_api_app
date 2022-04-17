import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_api_app/models/user_detail_model.dart';
import 'package:test_api_app/models/users_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://reqres.in/api/';

  Future<UsersModel> fetchUsers() async {
    try {
      final response = await _dio.get(_baseUrl + 'users');

      return UsersModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<UserDetailModel> fetchUserDetail({required String id}) async {
    try {
      final response = await _dio.get(_baseUrl + 'users/$id');

      return UserDetailModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
