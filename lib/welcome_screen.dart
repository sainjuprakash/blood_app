import 'dart:ui';

import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Login/Bloc/authentication_bloc/authentication_bloc.dart';
import 'package:blood_app/Features/Login/Bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:blood_app/Features/Login/Bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:blood_app/Features/Login/Screens/sign_in_screen.dart';
import 'package:blood_app/Features/Login/Screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amberAccent,
                  ),
                ),
              ),
              // Container(
              //   color: Colors.indigo,
              //     height:20,
              //     width:20,child: Text('TEXT')),
              Align(
                alignment: const AlignmentDirectional(-2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Theme.of(context).colorScheme.primary
                      color: Colors.green),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Colors.black87.withOpacity(0.4),
                          labelColor: Colors.black87,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign-In',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign-Up',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: BlocProvider(
                              create: (context) => SignInBloc(
                                  userRepository: context
                                      .read<AuthenticationBloc>()
                                      .userRepostitory),
                              child: SignInScreen(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: BlocProvider(
                              create: (context) => SignUpBloc(
                                  userRepostitory: context
                                      .read<AuthenticationBloc>()
                                      .userRepostitory),
                              child: SignUpScreen(),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
