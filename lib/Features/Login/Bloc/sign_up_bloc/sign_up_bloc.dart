import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_app/Features/Login/Screens/sign_up_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../model/user_model.dart';
import '../../user_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepositiory _userRepostitory;
  SignUpBloc({required userRepostitory})
      : _userRepostitory = userRepostitory,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async{
      emit(SignUpProcess());
      try {
        MyUser user= await _userRepostitory.signUp(event.user, event.password);
        await _userRepostitory.setUserData(user);
        emit (SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
