import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants.dart';
import '/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'sumit123210@gmail.com', password: 'Pythagon@12345#');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pythagon Tutors',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: kLogoRedColor,
      ),
      home: Welcome(),
    );
  }
}
