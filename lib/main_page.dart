import 'dart:developer';

import 'package:blood_app/Features/Login/Bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Request_blood/Screens/request_blood_page.dart';
import 'package:blood_app/Features/Request_blood/bloc/request_blood_bloc.dart';
import 'package:blood_app/Features/Request_blood/blood_request_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Login/Bloc/authentication_bloc/authentication_bloc.dart';
import 'Features/Login/Bloc/my_user_bloc/my_user_bloc.dart';
import 'Features/Login/firebase_user_repo.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // @override
  // void initState() {
  //   String users = context.read<AuthenticationBloc>().state.user!.uid;
  //   print(users);
  //   print('--------------------');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyUserBloc(userRepositiory: FirebaseUserRepo()),
      //..add(const GetMyUser(myUserId: '11')),
      child: Scaffold(
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     if (state.status == MyUserStatus.success) {
//       print('My User state success');
//       Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) =>
//               BlocProvider<RequestBloodBloc>(
//             create: (context) => RequestBloodBloc(
//                 bloodRequestRepository: FirebasePostRepository()),
//             child: RequestBloodPage(),
//           ),
//         ),
//       );
//     } else if(state.status==MyUserStatus.failure) {
//       print('Myuser state failure');
//       return;
//     }
//     else if(state.status==MyUserStatus.loading){
//       print('loading');
//       return;}
//     else{
//       print('unknown');
//       return;}
//   },
//   child: Icon(Icons.add),
// ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('blood app'),
        ),
        drawer: BlocConsumer<MyUserBloc, MyUserState>(
          listener: (context, state) {
            //print('Listener block');
            if (state.status == MyUserStatus.success) {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      BlocProvider<RequestBloodBloc>(
                    create: (context) => RequestBloodBloc(
                        bloodRequestRepository: FirebasePostRepository()),
                    child: RequestBloodPage(
                      myUser: state.user!,
                    ),
                  ),
                ),
              );
            } else if (state.status == MyUserStatus.failure) {
              print('Myuser state failure');
              return;
            } else if (state.status == MyUserStatus.loading) {
              print('loading');
              // context.read<MyUserBloc>().add(GetMyUser(myUserId: 'id1bxMyvBTfQYVi5nLS2tIasUmi1'));
            } else {
              return;
            }
            // if (state == MyUserState.loading()) {
            //   context
            //       .read<MyUserBloc>()
            //       .add(GetMyUser(myUserId: 'id1bxMyvBTfQYVi5nLS2tIasUmi1'));
            // }
          },
          builder: (context, state) {
            return Drawer(
              backgroundColor: Colors.red,
              width: MediaQuery.of(context).size.width / 1.42,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(CupertinoIcons.add),
                    title: Text('Request blood'),
                    onTap: () {
                      //if (state.status == MyUserStatus.success) {}
                      context.read<MyUserBloc>().add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid));

                      // print(context.read<AuthenticationBloc>().state.user);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Log Out'),
                    onTap: () {
                      context.read<SignInBloc>().add(SignOutRequired());
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: Container(),
      ),
    );
  }
}
