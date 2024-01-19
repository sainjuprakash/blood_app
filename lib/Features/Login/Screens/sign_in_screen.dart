import 'package:blood_app/Features/Constant/App_text.dart';
import 'package:blood_app/Features/Constant/custom_text_from_field.dart';
import 'package:blood_app/Features/Login/Bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;
  bool obssecurePassword = true;
  String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //   content: Text('Invalid email or password'),
            //   backgroundColor: Colors.redAccent,
            //   duration: Duration(milliseconds: 800),
            // ));
          });
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obsecureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(CupertinoIcons.mail_solid),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter email';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                      .hasMatch(val)) {
                    return 'please enter valid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obsecureText: obssecurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(
                  CupertinoIcons.lock_fill,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obssecurePassword = !obssecurePassword;
                      if (obssecurePassword) {
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
                    return 'please enter password';
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                      .hasMatch(val)) {
                    return 'please enter valid password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              !signInRequired
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInRequired(
                                  emailController.text,
                                  passwordController.text));
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
                              'Sign-In',
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
