part of 'request_blood_bloc.dart';

sealed class RequestBloodState extends Equatable {
  @override
  List<Object> get props => [];
}

class bloodRequestInitial extends RequestBloodState {}

class bloodRequestSuccess extends RequestBloodState {
  final RequestBlood requestpost;
  bloodRequestSuccess(this.requestpost);
}

class bloodRequestFailure extends RequestBloodState {
  final String? errmsg;
  bloodRequestFailure({this.errmsg});
}

class bloodRequestProcess extends RequestBloodState {}
