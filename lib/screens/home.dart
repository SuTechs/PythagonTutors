import 'package:flutter/material.dart';
import 'package:tutors/widgets/assignmentListTile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentsListView(length: 10);
  }
}

class Work extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentsListView(length: 2);
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentsListView(length: 4);
  }
}
