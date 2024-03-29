import 'dart:developer';

import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Login/Bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Request_blood/Get_Post_Bloc/get_post_bloc.dart';
import 'package:blood_app/Features/Request_blood/Screens/request_blood_page.dart';
import 'package:blood_app/Features/Request_blood/blood_request_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Login/Bloc/authentication_bloc/authentication_bloc.dart';
import 'Features/Login/Bloc/my_user_bloc/my_user_bloc.dart';
import 'Features/Login/firebase_user_repo.dart';
import 'Features/Request_blood/Request_blood_bloc/request_blood_bloc.dart';

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
    return GestureDetector(
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
                      print('***************************************');
                      print('request button tapped');
                      //if (state.status == MyUserStatus.success) {}
                      context.read<MyUserBloc>().add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid));
                      Navigator.pop(context);

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
        body: BlocBuilder<GetPostBloc, GetPostState>(
          builder: (context, state) {
            if (state is GetPostSuccess) {
              return ListView.builder(
                  itemCount: state.getBlood.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Text('Patient Name:'),
                                  AppLargeText(
                                    text: 'Patient Name :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].patientname)
                                ],
                              ),
                              Row(
                                children: [
                                  // const Text('Purpose:'),
                                  AppLargeText(
                                    text: 'Purpose :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].purpose)
                                ],
                              ),
                              Row(
                                children: [
                                  //  Text('Blood Group:'),
                                  AppLargeText(
                                    text: 'BloodGroup :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].bloodgroup)
                                ],
                              ),
                              Row(
                                children: [
                                  //const Text('No of pins:'),
                                  AppLargeText(
                                    text: 'Number of pins :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].pins.toString())
                                ],
                              ),
                              Row(
                                children: [
                                  // const Text('Location:'),
                                  AppLargeText(
                                    text: 'Loacation :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].location)
                                ],
                              ),
                              Row(
                                children: [
                                  //const Text('Required on:'),
                                  AppLargeText(
                                    text: 'Required date :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].dateofrequire)
                                ],
                              ),
                              Row(
                                children: [
                                  //  const Text('Posted by:'),
                                  AppLargeText(
                                    text: 'Posted by :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].fullname)
                                ],
                              ),
                              Row(
                                children: [
                                  // const Text('Contact Number:'),
                                  AppLargeText(
                                    text: 'Contact Number :',
                                    size: 10,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.getBlood[i].contact.toString())
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state is GetPostFailure) {
              return const Center(child: Text('Post fetch failure'));
            } else if (state is GetPostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else
              return Center(child: const Text('no post'));
          },
        ),
      ),
    );
  }
}
