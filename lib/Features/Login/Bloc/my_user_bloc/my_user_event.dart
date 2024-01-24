part of 'my_user_bloc.dart';

@immutable
abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent {
  final String myUserId;
 GetMyUser({required this.myUserId}){
   // print('hello');
  }

  @override
  List<Object> get props => [myUserId];
}
