import 'dart:math';

import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Constant/custom_text_from_field.dart';
import 'package:blood_app/Features/Login/Bloc/my_user_bloc/my_user_bloc.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:blood_app/Features/Request_blood/bloc/request_blood_bloc.dart';
import 'package:blood_app/Features/Request_blood/blood_model.dart';
import 'package:blood_app/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

//

class RequestBloodPage extends StatefulWidget {
  final MyUser myUser;
  const RequestBloodPage({required this.myUser, super.key});

  @override
  State<RequestBloodPage> createState() => _RequestBloodPageState();
}

class _RequestBloodPageState extends State<RequestBloodPage> {
  late RequestBlood createdblood;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _contactController = TextEditingController();
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
    createdblood = RequestBlood.empty;
    createdblood.user = widget.myUser;
    createdblood.fullname = widget.myUser.name;
    // blood.user=context.read().state.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(blood.toString() as num);
    print(createdblood);
    return BlocListener<RequestBloodBloc, RequestBloodState>(
      listener: (context, state) {
        if (state is bloodRequestSuccess) {
          setState(() {
            request = false;
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MainPage()));
          });
        }
        if (state is bloodRequestProcess) {
          setState(() {
            request = true;
          });
        }
        if (state is bloodRequestFailure) {
          setState(() {
            request = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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

                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _patientController,
                            validator: (patient) {
                              if (patient!.isEmpty) {
                                return 'patient name is required';
                              }
                              return null;
                            },
                            hintText: 'patient name',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _locationController,
                            validator: (location) {
                              if (location!.isEmpty) {
                                return 'location is required';
                              }
                            },
                            hintText: 'location',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _dorController,
                            validator: (dor) {
                              if (dor!.isEmpty) {
                                return 'please enter the date you require blood';
                              }
                              return null;
                            },
                            hintText: 'date of require',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _pinsController,
                            validator: (pins) {
                              if (pins!.isEmpty) {
                                return 'please enter the number of pins';
                              }
                            },
                            hintText: 'no.of pins in digit',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _bloodgroupController,
                            validator: (bloodgroup) {
                              if (bloodgroup!.isEmpty) {
                                return 'blood group is required';
                              }
                              return null;
                            },
                            hintText: 'blood group',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _purposeController,
                            validator: (purpose) {
                              if (purpose!.isEmpty) {
                                return 'enter the purpose';
                              }
                              return null;
                            },
                            hintText: 'purpose',
                            obsecureText: false,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: _contactController,
                            validator: (contact) {
                              if (contact!.isEmpty) {
                                return 'Please enter your contact number';
                              } if(contact.length != 10){
                                return 'enter valid contact number';
                              }
                              if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(contact)){
                                return 'contact is not from nepal';
                              }
                              return null;
                            },
                            hintText: 'contact number',
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
                                      // FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          // createdblood.fullname =
                                          //     _nameController.text;
                                          createdblood.patientname =
                                              _patientController.text;
                                          createdblood.purpose =
                                              _purposeController.text;
                                          createdblood.bloodgroup =
                                              _bloodgroupController.text;
                                          createdblood.pins =
                                              int.parse(_pinsController.text);
                                          createdblood.location =
                                              _locationController.text;
                                          createdblood.dateofrequire =
                                              _dorController.text;
                                          createdblood.contact= int.parse(_contactController.text);
                                        });
                                        context.read<RequestBloodBloc>().add(
                                            bloodRequestDone(createdblood));
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        elevation: 3.0,
                                        backgroundColor:
                                            Colors.deepOrange.withOpacity(0.5),
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
      ),
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
