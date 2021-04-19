import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeLogin(
      onPressed: () {
        Get.to(() => LoginName(), transition: Transition.downToUp);
      },
    );
  }
}

/// name

class LoginName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginInputScreen(
      title: 'What is your name?',
      currentStep: 1,
      backgroundColor: const Color(0xffF4B532),
      image: 'assets/images/name.png',
      onNext: () {
        Get.to(() => Phone(), transition: Transition.cupertino);
      },
    );
  }
}

/// phone
class Phone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginInputScreen(
      title: 'What is your phone number?',
      currentStep: 2,
      backgroundColor: const Color(0xffE94D78),
      image: 'assets/images/phone.png',
      onNext: () {
        Get.to(() => Subject(), transition: Transition.cupertino);
      },
    );
  }
}

/// subject
class Subject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginInputScreen(
      title: 'What are the subjects you are good in?',
      currentStep: 3,
      backgroundColor: const Color(0xff774BEE),
      image: 'assets/images/subject.png',
      onNext: () {
        Get.to(() => College(), transition: Transition.cupertino);
      },
    );
  }
}

/// college
class College extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginInputScreen(
      title: 'What is your college name?',
      currentStep: 4,
      backgroundColor: const Color(0xffF4B532),
      image: 'assets/images/college.png',
      onNext: () {
        Get.to(() => Born(), transition: Transition.cupertino);
      },
    );
  }
}

/// born
class Born extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginInputScreen(
      title: 'When were you born?',
      currentStep: 5,
      backgroundColor: const Color(0xff774BEE),
      image: 'assets/images/born.png',
      onNext: () {
        Get.offAll(() => Welcome(), transition: Transition.upToDown);
      },
    );
  }
}
