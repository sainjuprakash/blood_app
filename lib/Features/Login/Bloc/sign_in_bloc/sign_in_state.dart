part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}
final class SignInInitial extends SignInState{}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String? errmsg;
  SignInFailure({this.errmsg});
}

class SignInProcess extends SignInState {}
