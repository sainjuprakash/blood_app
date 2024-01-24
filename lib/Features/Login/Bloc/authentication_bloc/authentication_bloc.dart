import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blood_app/Features/Login/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepositiory userRepostitory;
  late final StreamSubscription<User?> _userSubscription;
  AuthenticationBloc({required this.userRepostitory})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepostitory.user.listen((user) {
      add(AuthenticationUserChanged(user: user));
    });
    on<AuthenticationUserChanged>((event, emit) {

      if (event.user != null) {
      //  print(event.user);
        emit(AuthenticationState.authenticated(event.user!));

      } else {
        emit(AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
