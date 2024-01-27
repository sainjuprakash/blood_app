import 'dart:math';
import 'package:blood_app/Features/Login/Bloc/authentication_bloc/authentication_bloc.dart';
import 'package:blood_app/Features/Login/Bloc/my_user_bloc/my_user_bloc.dart';
import 'package:blood_app/Features/Request_blood/Get_Post_Bloc/get_post_bloc.dart';
import 'package:blood_app/Features/Request_blood/blood_request_repository.dart';
import 'package:blood_app/welcome_screen.dart';
import 'package:blood_app/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/sign_in_bloc/sign_in_bloc.dart';
import 'model/user_model.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // print(state.Status);

          if (state.Status == AuthenticationStatus.authenticated) {
            //print(state.user!.uid);
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                      context.read<AuthenticationBloc>().userRepostitory),
                ),
                BlocProvider(
                    create: (context) =>
                    GetPostBloc(postRepository: FirebasePostRepository())
                      ..add(GetPost())),
                BlocProvider(
                    create: (context) => MyUserBloc(
                        userRepositiory:
                        context.read<AuthenticationBloc>().userRepostitory
                    )
                  // ..add(GetMyUser(
                  //     myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
                ),
              ],
              child: const MainPage(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}