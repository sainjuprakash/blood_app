import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Constant/custom_text_from_field.dart';
import 'package:blood_app/Features/Login/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signUpRequired = false;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;
  bool obsecurePassword = true;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextField(
                prefixIcon: Icon(CupertinoIcons.person_fill),
                controller: nameController,
                hintText: 'name',
                obsecureText: false,
                keyboardType: TextInputType.text,
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'please provide your name';
                  } else if (name.length > 30) {
                    return 'name too long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obsecureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(CupertinoIcons.mail_solid),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please provide your email';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                      .hasMatch(val)) {
                    return 'please enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obsecureText: obsecurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(
                  CupertinoIcons.lock_fill,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecurePassword = !obsecurePassword;
                      if (obsecurePassword) {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please provide your password';
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                      .hasMatch(val)) {
                    return 'please enter valid password';
                  }
                  return null;
                },
                onChanged: (val) {
                  if (val!.contains(RegExp(r'[A-Z]'))) {
                    setState(() {
                      containsUpperCase = true;
                    });
                  } else {
                    setState(() {
                      containsUpperCase = false;
                    });
                  }
                  if (val.contains(RegExp(r'[a-z]'))) {
                    setState(() {
                      containsLowerCase = true;
                    });
                  } else {
                    setState(() {
                      containsLowerCase = false;
                    });
                  }
                  if (val.contains(RegExp(r'[0-9]'))) {
                    setState(() {
                      containsNumber = true;
                    });
                  } else {
                    setState(() {
                      containsNumber = false;
                    });
                  }
                  if (val.contains(RegExp(
                      r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                    setState(() {
                      containsSpecialChar = true;
                    });
                  } else {
                    setState(() {
                      containsSpecialChar = false;
                    });
                  }
                  if (val.length >= 8) {
                    setState(() {
                      contains8Length = true;
                    });
                  } else {
                    setState(() {
                      contains8Length = false;
                    });
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                            text: '⚈ 1 UpperCase',
                            size: 10,
                            textColor: containsUpperCase
                                ? Colors.green
                                : Colors.black87),
                        AppLargeText(
                            text: '⚈ 1 LowerCase',
                            size: 10,
                            textColor: containsLowerCase
                                ? Colors.green
                                : Colors.black87),
                        AppLargeText(
                            text: '⚈ 1 Number',
                            size: 10,
                            textColor:
                                containsNumber ? Colors.green : Colors.black87),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                            text: '⚈ 1 Special Character',
                            size: 10,
                            textColor: containsSpecialChar
                                ? Colors.green
                                : Colors.black87),
                        AppLargeText(
                            text: '⚈ 8 minimun character',
                            size: 10,
                            textColor: contains8Length
                                ? Colors.green
                                : Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              !signUpRequired
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              MyUser myUer = MyUser.empty;
                              myUer = myUer.copyWith(
                                  email: emailController.text,
                                  name: nameController.text);
                              setState(() {
                                context.read<SignUpBloc>().add(SignUpRequired(
                                    myUer, passwordController.text));
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              'Sign-Up',
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
          )),
    );
  }
}
