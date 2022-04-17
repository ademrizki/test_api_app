import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_api_app/bloc/user_detail_event.dart';
import 'package:test_api_app/bloc/user_detail_state.dart';
import 'package:test_api_app/models/user_detail_model.dart';
import 'package:test_api_app/services/services.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc() : super(LoadingState()) {
    final ApiService service = ApiService();

    /// On Fetch User Detail
    on<GetUserDetail>(
      (event, emit) async {
        try {
          emit(LoadingState());

          /// Fetch data
          final UserDetailModel result =
              await service.fetchUserDetail(id: event.id);

          emit(SuccessState(result));
        } catch (e) {
          emit(
            ErrorState(e, e.toString()),
          );
        }
      },
    );
  }
}
