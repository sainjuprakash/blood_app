import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../user_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepositiory _userRepository;
  SignInBloc({
    required UserRepositiory userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(errmsg: e.code));
      } catch (e) {
        emit(SignInFailure(errmsg: e.toString()));
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.LogOut();
    });
  }
}
