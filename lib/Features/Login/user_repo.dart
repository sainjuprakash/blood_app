import 'package:blood_app/Features/Login/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepositiory {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUserrrr, String password);

  Future<void> signIn(String email, String password) ;

  Future<void> setUserData(MyUser user);

  Future<void> LogOut();

  Future<MyUser> getMyUser(String myUserId);
}
