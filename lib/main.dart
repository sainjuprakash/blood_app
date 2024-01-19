import 'package:blood_app/Features/Login/Bloc/authentication_bloc/authentication_bloc.dart';
import 'package:blood_app/Features/Login/app_view.dart';
import 'package:blood_app/Features/Login/firebase_user_repo.dart';
import 'package:blood_app/Features/WelcomePage.dart';
import 'package:blood_app/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/Login/user_repo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(FirebaseUserRepo()));
}

class MyApp extends StatelessWidget {
  final UserRepositiory userRepository;

  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepostitory: userRepository),
        ),
      ],
      child: MyAppView(),
    );
  }
}
