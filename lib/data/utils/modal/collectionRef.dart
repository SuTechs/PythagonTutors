import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionRef {
  static final colleges = FirebaseFirestore.instance.collection('Colleges');
  static final courses = FirebaseFirestore.instance.collection('Courses');
  static final subjects = FirebaseFirestore.instance.collection('Subjects');

  static final teachers = FirebaseFirestore.instance.collection('Teachers');
  static final assignments =
      FirebaseFirestore.instance.collection('Assignments');
  static final teachersAssignments =
      FirebaseFirestore.instance.collection('TeachersAssignments');
}
