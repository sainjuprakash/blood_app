part of 'request_blood_bloc.dart';

sealed class RequestBloodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class bloodRequestDone extends RequestBloodEvent {
  final RequestBlood requestblood;
  bloodRequestDone(this.requestblood);
}
