import 'package:firebase_auth/firebase_auth.dart';

import '../../database.dart';

class UserData {
  // singleton
  // static final UserData _singleton = UserData._internal();
  // factory UserData() {
  //   return _singleton;
  // }
  // UserData._internal();

  static User get authData => FirebaseAuth.instance.currentUser!;

  static late Teacher teacher;

  static void fetchTeacher() {
    Teacher.fetchIfExist(authData);
  }
}
