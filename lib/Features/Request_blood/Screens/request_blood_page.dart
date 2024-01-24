import 'dart:math';

import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Constant/custom_text_from_field.dart';
import 'package:blood_app/Features/Login/Bloc/my_user_bloc/my_user_bloc.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Request_blood/bloc/request_blood_bloc.dart';
import 'package:blood_app/Features/Request_blood/blood_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//

class RequestBloodPage extends StatefulWidget {
  final MyUser myUser;
  const RequestBloodPage({required this.myUser, super.key});

  @override
  State<RequestBloodPage> createState() => _RequestBloodPageState();
}

class _RequestBloodPageState extends State<RequestBloodPage> {
  late RequestBlood blood;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _patientController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dorController = TextEditingController();
  TextEditingController _pinsController = TextEditingController();
  TextEditingController _bloodgroupController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  bool request = false;

  @override
  void initState() {
    print(widget.myUser);
    blood = RequestBlood.empty;
    blood.user = widget.myUser;
    // blood.user=context.read().state.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(blood.toString() as num);
    print(blood);
    return BlocListener<RequestBloodBloc, RequestBloodState>(
      listener: (context, state) {},
      child: Scaffold(
          backgroundColor: Colors.deepOrange.withOpacity(0.5),
          body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 100.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      MyTextField(
                          controller: _nameController,
                          hintText: 'name',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _patientController,
                          hintText: 'patient name',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _locationController,
                          hintText: 'location',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _dorController,
                          hintText: 'date of require',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _pinsController,
                          hintText: 'no.of pins',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _bloodgroupController,
                          hintText: 'blood group',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: _purposeController,
                          hintText: 'purpose',
                          obsecureText: false,
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 20,
                      ),
                      !request
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextButton(
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    //   context.read<SignInBloc>().add(SignInRequired(
                                    //       emailController.text,
                                    //       passwordController.text));
                                    // }
                                  },
                                  style: TextButton.styleFrom(
                                      elevation: 3.0,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(60))),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Text(
                                      'Request now',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            )
                          : const CircularProgressIndicator(),
                    ],
                  ),
                )),
          )),
    );
  }
}

// class BloodRequest extends StatefulWidget {
//   late  RequestBlood myuserr;
//   const BloodRequest({required this.myuserr,super.key});
//
//   @override
//   void initState() {
//     myuserr = .empty;
//     myuserr.user = widget.myUser;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     late BloodRequest requestblood;
//     final _formKey = GlobalKey<FormState>();
//     TextEditingController _nameController = TextEditingController();
//     TextEditingController _patientController = TextEditingController();
//     TextEditingController _locationController = TextEditingController();
//     TextEditingController _dorController = TextEditingController();
//     TextEditingController _pinsController = TextEditingController();
//     TextEditingController _bloodgroupController = TextEditingController();
//     TextEditingController _purposeController = TextEditingController();
//     bool request = false;
//
//     return Scaffold(
//       backgroundColor: Colors.deepOrange.withOpacity(0.5),
//         body: SingleChildScrollView(
//       child: Container(
//           // key: _formKey,
//           child: Padding(
//         padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
//         child: Column(
//           children: [
//             MyTextField(
//                 controller: _nameController,
//                 hintText: 'name',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _patientController,
//                 hintText: 'patient name',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _locationController,
//                 hintText: 'location',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _dorController,
//                 hintText: 'date of require',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _pinsController,
//                 hintText: 'no.of pins',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _bloodgroupController,
//                 hintText: 'blood group',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 10,
//             ),
//             MyTextField(
//                 controller: _purposeController,
//                 hintText: 'purpose',
//                 obsecureText: false,
//                 keyboardType: TextInputType.text),
//             SizedBox(
//               height: 20,
//             ),
//             !request
//                 ? SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     child: TextButton(
//                         onPressed: () {
//                           // if (_formKey.currentState!.validate()) {
//                           //   context.read<SignInBloc>().add(SignInRequired(
//                           //       emailController.text,
//                           //       passwordController.text));
//                           // }
//                         },
//                         style: TextButton.styleFrom(
//                             elevation: 3.0,
//                             backgroundColor:
//                                 Theme.of(context).colorScheme.primary,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(60))),
//                         child: const Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//                           child: Text(
//                             'Request now',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         )),
//                   )
//                 : const CircularProgressIndicator(),
//           ],
//         ),
//       )),
//     ));
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
