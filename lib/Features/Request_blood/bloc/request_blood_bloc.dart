import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blood_app/Features/Request_blood/blood_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../blood_request_repo.dart';
import '../blood_request_repository.dart';

part 'request_blood_event.dart';
part 'request_blood_state.dart';

class RequestBloodBloc extends Bloc<RequestBloodEvent, RequestBloodState> {
  final BloodRequestRepository _bloodRequestRepository;
  RequestBloodBloc({required BloodRequestRepository bloodRequestRepository})
      : _bloodRequestRepository = bloodRequestRepository,
        super(bloodRequestInitial()) {
    on<bloodRequestDone>((event, emit) async {
      emit(bloodRequestProcess());
      try {
       RequestBlood postrequest =await  _bloodRequestRepository.createPost(event.requestblood);
       emit(bloodRequestSuccess(postrequest));
      } on FirebaseAuthException catch (e) {
        emit(bloodRequestFailure(errmsg: e.code));
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }
}
