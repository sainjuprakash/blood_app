import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../user_repo.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  // MyUser dummyuser= MyUser(userId: '5', email: 'email', name: 'name');
  final UserRepositiory userRepositiory;
  MyUserBloc({required this.userRepositiory})
      : super(const MyUserState.loading())

   {
   // print('entered loading state');
    on<GetMyUser>((event, emit) async {
     // print('on get user event');
     // print(event);
      try {
        //print('entered try statement');
        //print(event.myUserId);
        MyUser myuser = await userRepositiory.getMyUser(event.myUserId);
        //print(myuser);
        emit(MyUserState.success(myuser));
      } catch (e) {
        print(e.toString());
        log(e.toString());
        emit(MyUserState.failure());
        print('entered failure');
      }
    });
  }
}
