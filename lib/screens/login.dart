import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tutors/data/bloc/login.dart';
import 'package:tutors/data/utils/modal/user.dart';

import '/data/database.dart';
import '/widgets/login.dart';
import '/widgets/selectFromList.dart';
import '/widgets/showRoundedBottomSheet.dart';
import 'navigationHome.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeLogin(
      onPressed: () async {
        LoginBloc.signInWithGoogle();
      },
    );
  }
}

class HomeLogic extends StatelessWidget {
  final User user;

  const HomeLogic({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Teacher.fetchIfExist(user),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error 52527 = ${snapshot.error}');
          Get.snackbar(
            'Something went wrong!',
            'It looks like we got some error #2321',
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data!) return NavigationHome();

          return LoginName();
        }

        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

/// name

class LoginName extends StatelessWidget {
  late final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = UserData.teacher.name;

    return LoginInputScreen(
      title: 'What is your name?',
      currentStep: 1,
      backgroundColor: const Color(0xffF4B532),
      image: 'assets/images/name.png',
      onNext: () {
        UserData.teacher.name = _controller.text.trim();

        Get.to(() => Phone(), transition: Transition.cupertino);
      },

      // input
      controller: _controller,
      label: 'Name',
      keyboardType: TextInputType.name,
    );
  }
}

/// phone
class Phone extends StatelessWidget {
  late final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = UserData.teacher.phone;
    return LoginInputScreen(
      title: 'What is your phone number?',
      currentStep: 2,
      backgroundColor: const Color(0xffE94D78),
      image: 'assets/images/phone.png',

      onNext: () {
        UserData.teacher.phone = _controller.text.trim();

        Get.to(() => SubjectScreen(), transition: Transition.cupertino);
      },

      // input
      controller: _controller,
      label: 'Phone',
      prefixText: '+91',
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    );
  }
}

/// subject
class SubjectScreen extends StatelessWidget {
  late final TextEditingController _subjectsList = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _subjectsList.text = UserData.teacher.subjectsIds.join(', ');

    return LoginInputScreen(
      title: 'What are the subjects you are good in?',
      currentStep: 3,
      backgroundColor: const Color(0xff774BEE),
      image: 'assets/images/subject.png',
      onNext: () {
        Get.to(() => CollegeScreen(), transition: Transition.cupertino);
      },

      // input
      controller: _subjectsList,
      label: 'Select Subjects',
      isReadOnly: true,
      onTap: () {
        showRoundedBottomSheet(
          context: context,
          child: FutureBuilder<List<Subject>>(
              future: Subject.getSubjects(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error = ${snapshot.error}'));
                }

                if (snapshot.hasData)
                  return SelectMultipleSubjects(
                    subjects: snapshot.data!,
                    initiallySelectedSubjectsIds: UserData.teacher.subjectsIds,
                    onSelect: (value) {
                      UserData.teacher.subjectsIds =
                          value.map((e) => e.id).toList();
                      _subjectsList.text =
                          value.map((e) => e.name).toList().join(", ");
                    },
                  );

                return Center(child: CircularProgressIndicator());
              }),
        );
      },
    );
  }
}

/// college
class CollegeScreen extends StatelessWidget {
  late final TextEditingController _college = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _college.text = UserData.teacher.college.collegeName;

    return LoginInputScreen(
      title: 'What is your college name?',
      currentStep: 4,
      backgroundColor: const Color(0xffF4B532),
      image: 'assets/images/college.png',
      onNext: () {
        Get.to(() => CourseScreen(), transition: Transition.cupertino);
      },

      // input
      controller: _college,
      label: 'College Name',
      isReadOnly: true,
      onTap: () {
        showRoundedBottomSheet(
          context: context,
          child: FutureBuilder<List<College>>(
              future: College.getColleges(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error = ${snapshot.error}'));
                }

                if (snapshot.hasData)
                  return SelectFromList<College>(
                    items: snapshot.data!
                        .map((e) => ListItem<College>(e, e.collegeName))
                        .toList(),
                    onNewItemSelect: (newItem) {
                      College(collegeId: newItem, collegeName: newItem)
                          .addCollege();
                      _college.text = newItem;
                    },
                    onSelect: (value) {
                      UserData.teacher.college = value;
                      _college.text = value.collegeName;
                    },
                  );

                return Center(child: CircularProgressIndicator());
              }),
        );
      },
    );
  }
}

/// course
class CourseScreen extends StatelessWidget {
  late final TextEditingController _course = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _course.text = UserData.teacher.course.courseName;

    return LoginInputScreen(
      title: 'Which course you are in?',
      currentStep: 5,
      backgroundColor: const Color(0xff50BEA4),
      image: 'assets/images/subject.png',
      onNext: () {
        Get.to(() => Born(), transition: Transition.cupertino);
      },

      // input
      controller: _course,
      label: 'Course',
      isReadOnly: true,
      onTap: () {
        showRoundedBottomSheet(
          context: context,
          child: FutureBuilder<List<Course>>(
              future: Course.getCourses(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error = ${snapshot.error}'));
                }

                if (snapshot.hasData)
                  return SelectFromList<Course>(
                    items: snapshot.data!
                        .map((e) => ListItem<Course>(e, e.courseName))
                        .toList(),
                    onNewItemSelect: (newItem) {
                      Course(courseId: newItem, courseName: newItem)
                          .addCourse();
                      _course.text = newItem;
                    },
                    onSelect: (value) {
                      UserData.teacher.course = value;
                      _course.text = value.courseName;
                    },
                  );

                return Center(child: CircularProgressIndicator());
              }),
        );
      },
    );
  }
}

/// born
class Born extends StatelessWidget {
  late final TextEditingController _dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _dob.text = UserData.teacher.dateOfBirth;

    return LoginInputScreen(
      title: 'When were you born?',
      currentStep: 6,
      backgroundColor: const Color(0xff774BEE),
      image: 'assets/images/born.png',
      onNext: () {
        UserData.teacher.addOrUpdateTeacher(true);

        Get.offAll(() => NavigationHome(), transition: Transition.upToDown);
      },

      // input
      controller: _dob,
      label: 'DOB',
      keyboardType: TextInputType.datetime,
      isReadOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          useRootNavigator: false,
          context: context,
          initialDate: DateTime(2000),
          lastDate: DateTime.now(),
          firstDate: DateTime(1980),
        );
        if (pickedDate != null) {
          _dob.text = pickedDate.toString().substring(0, 10);
          UserData.teacher.dateOfBirth = _dob.text;
        }
      },
    );
  }
}
