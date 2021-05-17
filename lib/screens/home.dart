import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutors/data/bloc/assignmentList.dart';
import 'package:tutors/data/database.dart';
import 'package:tutors/widgets/assignmentListTile.dart';

class Home extends GetView<AssignmentListController> {
  final assignmentList = Get.put(AssignmentListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AssignmentsListView(
          assignments: AssignmentListController.teacherAssignments
              .where(
                  (element) => element.status == TeacherAssignmentStatus.Sent)
              .toList(),
        ),
      ),
    );
  }
}

class Work extends GetView<AssignmentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AssignmentsListView(
          assignments: AssignmentListController.teacherAssignments
              .where((element) =>
                  element.status != TeacherAssignmentStatus.Sent &&
                  element.status != TeacherAssignmentStatus.Closed &&
                  element.status != TeacherAssignmentStatus.Rated &&
                  element.status != TeacherAssignmentStatus.NotInterested)
              .toList(),
        ),
      ),
    );
  }
}

class History extends GetView<AssignmentListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AssignmentsListView(
          assignments: AssignmentListController.teacherAssignments
              .where((element) =>
                  element.status == TeacherAssignmentStatus.Closed ||
                  element.status == TeacherAssignmentStatus.Rated)
              .toList(),
        ),
      ),
    );
  }
}
