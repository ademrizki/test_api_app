import 'package:dio/dio.dart';
import 'package:test_api_app/models/sign_in_model.dart';
import 'package:test_api_app/models/user_detail_model.dart';
import 'package:test_api_app/models/users_model.dart';

class ApiService {
  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      if (e.response!.statusCode == 401) {
      } else {}
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }
  final Dio _dio = Dio();

  final String _baseUrl = 'https://reqres.in/api/';

  Future<UsersModel> fetchUsers() async {
    try {
      final response = await _dio.get(_baseUrl + 'users');

      return UsersModel.fromJson(response.data);
    } on DioError catch (e) {
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
    } on DioError catch (e) {
      rethrow;
    }
  }
}
