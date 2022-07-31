import 'package:dio/dio.dart';
import 'package:test_api_app/models/sign_in_model.dart';
import 'package:test_api_app/models/user_detail_model.dart';
import 'package:test_api_app/models/users_model.dart';

class ApiService {
  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          if (e.response!.statusCode == 401) {
          } else {}
          return handler.next(e);
        },
      ),
    );
  }
  final Dio _dio = Dio();

  final String _baseUrl = 'https://reqres.in/api/';

  Future<UsersModel> fetchUsers() async {
    try {
      final response = await _dio.get(_baseUrl + 'users');

      return UsersModel.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<UserDetailModel> fetchUserDetail({required String id}) async {
    try {
      final response = await _dio.get(_baseUrl + 'users/$id');

      return UserDetailModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<SignInModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        _baseUrl + 'login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return SignInModel.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
