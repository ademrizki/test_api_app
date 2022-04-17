abstract class UserDetailEvent {}

class GetUserDetail extends UserDetailEvent{
  final String id;

  GetUserDetail(this.id);
}
