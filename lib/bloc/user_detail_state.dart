import 'package:test_api_app/models/user_detail_model.dart';

abstract class UserDetailState {}

class LoadingState extends UserDetailState {}

class SuccessState extends UserDetailState {
  final UserDetailModel userDetail;

  SuccessState(this.userDetail);
}

class ErrorState extends UserDetailState {
  final Object error;
  final String errorMessage;

  ErrorState(this.error, this.errorMessage);
}
