import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '/data/utils/modal/collectionRef.dart';

class College {
  final String collegeName;
  final String collegeId;

  College({required this.collegeName, required this.collegeId});

  Map<String, dynamic> toJson() => {
        'collegeName': collegeName,
        'collegeId': collegeId,
        'createdAt': Timestamp.now(),
      };

  factory College.fromJson(Map<String, dynamic> json) => College(
        collegeName: json['collegeName'],
        collegeId: json['collegeId'],
      );

  Future<void> addCollege() async {
    await CollectionRef.colleges.doc(collegeId).set(toJson()).catchError((e) {
      print('Error #2526 $e');
    });
    _colleges.add(this);
  }

  static final List<College> _colleges = [];

  static Future<List<College>> getColleges() async {
    if (_colleges.isNotEmpty) return _colleges;

    final data = await CollectionRef.colleges.get();

    for (QueryDocumentSnapshot snapshot in data.docs)
      _colleges.add(College.fromJson(snapshot.data()));

    return _colleges;
  }
}

class Course {
  final String courseName;
  final String courseId;

  Course({required this.courseName, required this.courseId});

  Map<String, dynamic> toJson() => {
        'courseName': courseName,
        'courseId': courseId,
        'createdAt': Timestamp.now(),
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json['courseName'],
        courseId: json['courseId'],
      );

  Future<void> addCourse() async {
    _courses.add(this);
    await CollectionRef.courses.doc(courseId).set(toJson());
  }

  static final List<Course> _courses = [];

  static Future<List<Course>> getCourses() async {
    if (_courses.isNotEmpty) return _courses;

    final data = await CollectionRef.courses.get();

    for (QueryDocumentSnapshot snapshot in data.docs)
      _courses.add(Course.fromJson(snapshot.data()));

    return _courses;
  }
}

class Subject {
  static final List<Subject> subjects = [];
  final String id;
  final String name;
  final String image;

  Subject({required this.id, required this.name, required this.image});

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'image': image,
  //       'createdAt': Timestamp.now(),
  //     };

  // Future<void> addSubject() async {
  //   await CollectionRef.subjects.doc(id).set(toJson()).catchError((e) {
  //     print('Error #2526 $e');
  //   });
  //   subjects.add(this);
  // }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  static Future<List<Subject>> getSubjects() async {
    if (subjects.isNotEmpty) return subjects;

    final data = await CollectionRef.subjects.get();

    for (QueryDocumentSnapshot snapshot in data.docs)
      subjects.add(Subject.fromJson(snapshot.data()));

    return subjects;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Subject && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// teachers
enum TeacherAssignmentStatus {
  Sent,
  Interested,
  NotInterested,
  Assigned,
  NotAssigned,
  Completed,
  Rejected,
  Closed,
  Rated
}

const kTeacherAssignmentStatusEnumMap = {
  TeacherAssignmentStatus.Sent: 'Sent',
  TeacherAssignmentStatus.Interested: 'Interested',
  TeacherAssignmentStatus.NotInterested: 'Not Interested',
  TeacherAssignmentStatus.Assigned: 'Assigned',
  TeacherAssignmentStatus.NotAssigned: 'Not Assigned',
  TeacherAssignmentStatus.Completed: 'Completed',
  TeacherAssignmentStatus.Rejected: 'Rejected',
  TeacherAssignmentStatus.Closed: 'Closed',
  TeacherAssignmentStatus.Rated: 'Rated'
};

class TeacherRating {
  final double performance;
  final double accuracy;
  final double availability;

  double get avgRating => (performance + accuracy + availability) / 3;

  TeacherRating(
      {required this.performance,
      required this.accuracy,
      required this.availability});

  Map<String, dynamic> toJson() => {
        'performance': performance,
        'accuracy': accuracy,
        'availability': availability,
      };

  factory TeacherRating.fromJson(Map<String, dynamic> json) {
    return TeacherRating(
        performance: json['performance'],
        accuracy: json['accuracy'],
        availability: json['availability']);
  }
}

class Teacher {
  static final List<Teacher> _teachers = [];
  final String id;
  final String name;
  final String phone;
  final String profilePic;
  final String email;
  final TeacherRating rating;
  final int totalRating;
  final String dateOfBirth;
  final String gender;
  final College college;
  final List<String> subjectsIds;
  final double balance;

  Teacher(
      {required this.id,
      required this.name,
      required this.phone,
      required this.profilePic,
      required this.email,
      required this.rating,
      required this.subjectsIds,
      required this.dateOfBirth,
      required this.gender,
      required this.college,
      required this.balance,
      required this.totalRating});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Teacher &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            phone == other.phone &&
            email == other.email &&
            college.collegeId == other.college.collegeId &&
            listEquals(subjectsIds, other.subjectsIds) &&
            dateOfBirth == other.dateOfBirth &&
            gender == other.gender &&
            email == other.email;
  }

  @override
  int get hashCode => id.hashCode ^ phone.hashCode;

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'name': name,
        'phone': phone,
        'profilePic': profilePic,
        'email': email,
        'subjects': subjectsIds,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'college': college.collegeName,
        'rating': rating.toJson(),
        'totalRating': totalRating,
        'balance': balance,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      };

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      balance: json['balance'] ?? 0,
      profilePic: json['profilePic'],
      subjectsIds:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      rating: TeacherRating.fromJson(json['rating']),
      totalRating: json['totalRating'] ?? 0,
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      college:
          College(collegeId: json['college'], collegeName: json['college']),
    );
  }

  static Future<List<Teacher>> getTeachers() async {
    if (_teachers.isNotEmpty) return _teachers;

    final data = await CollectionRef.teachers.get();

    for (QueryDocumentSnapshot snapshot in data.docs)
      _teachers.add(Teacher.fromJson(snapshot.data()));

    return _teachers;
  }

  static void resetTeachers() {
    _teachers.clear();
  }

  Future<void> addOrUpdateTeacher(bool isEdit) async {
    print('${isEdit ? 'Update' : 'Create'} teacher');

    if (isEdit) {
      await CollectionRef.teachers.doc(id).update(toJson(isEdit));
      _teachers.removeWhere((element) => element.id == id);
    } else
      await CollectionRef.teachers.doc(id).set(toJson(isEdit));

    _teachers.add(this);
  }
}

class TeachersAssignments {
  final String id;
  final String assignmentId;
  final Teacher teacher;
  final double amount;
  final DateTime time;
  final TeacherAssignmentStatus status;
  final TeacherRating? rating;
  final List<String> assignmentFiles;

  TeachersAssignments({
    required this.id,
    required this.assignmentId,
    required this.teacher,
    required this.amount,
    required this.time,
    required this.status,
    this.rating,
    required this.assignmentFiles,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'assignmentId': assignmentId,
        'teacher': teacher.id,
        'amount': amount,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'status': kTeacherAssignmentStatusEnumMap[status],
        'rating': rating != null ? rating!.toJson() : null,
        'assignmentFiles': assignmentFiles,
      };

  factory TeachersAssignments.fromJson(
      Map<String, dynamic> json, List<Teacher> teachers) {
    return TeachersAssignments(
      id: json['id'],
      assignmentId: json['assignmentId'],
      teacher: teachers.firstWhere((element) => element.id == json['teacher']),
      amount: json['amount'],
      time: (json['updatedAt'] as Timestamp).toDate(),
      status: kTeacherAssignmentStatusEnumMap.entries
          .singleWhere((element) => element.value == json['status'])
          .key,
      rating: json['rating'] != null
          ? TeacherRating.fromJson(json['rating'])
          : null,
      assignmentFiles: json['assignmentFiles'] != null
          ? (json['assignmentFiles'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
    );
  }

  static Future<void> floatAssignments(
      List<String> selectedTeachers, String assignmentId, double amount) async {
    /// creating teachers assignments
    for (String teacherId in selectedTeachers) {
      final id = '${DateTime.now().millisecondsSinceEpoch}';

      await CollectionRef.teachersAssignments.doc(id).set({
        'id': id,
        'assignmentId': assignmentId,
        'teacher': teacherId,
        'amount': amount,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'status': kTeacherAssignmentStatusEnumMap[TeacherAssignmentStatus.Sent],
      });
    }
  }

  static Future<void> changeStatus(
      TeacherAssignmentStatus status, String id) async {
    await CollectionRef.teachersAssignments
        .doc(id)
        .update({'status': kTeacherAssignmentStatusEnumMap[status]});
  }

  static Future<void> updateFiles(List<String> files, String id) async {
    await CollectionRef.teachersAssignments
        .doc(id)
        .update({'assignmentFiles': files});
  }

  static Future<void> rate(TeacherRating rating, String teacherId, String id,
      TeacherRating currentRating, int totalCurrentRating) async {
    /// adding rating in teacher assignment
    await CollectionRef.teachersAssignments.doc(id).update({
      'rating': rating.toJson(),
      'status': kTeacherAssignmentStatusEnumMap[TeacherAssignmentStatus.Rated]
    });

    /// adding rating in teacher
    totalCurrentRating += 1;
    final teacherRating = TeacherRating(
        performance: (rating.performance + currentRating.performance) /
            totalCurrentRating,
        accuracy: (rating.performance + currentRating.performance) /
            totalCurrentRating,
        availability: (rating.performance + currentRating.performance) /
            totalCurrentRating);

    await CollectionRef.teachers.doc(teacherId).update({
      'rating': teacherRating.toJson(),
      'totalRating': totalCurrentRating,
    }).then((value) {
      Teacher.resetTeachers();
    });
  }
}
