part of 'my_user_bloc.dart';

@immutable
abstract class MyUserEvent extends Equatable {
  const MyUserEvent();
}
class GetMyUser extends MyUserEvent{
  final String myUserId;
  const GetMyUser({required this.myUserId});

  @override
  List<Object?> get props => [myUserId];
}
