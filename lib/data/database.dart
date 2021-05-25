import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tutors/data/utils/modal/user.dart';

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
        performance: double.tryParse(json['performance'].toString()) ?? 0,
        accuracy: double.tryParse(json['accuracy'].toString()) ?? 0,
        availability: double.tryParse(json['availability'].toString()) ?? 0);
  }
}

class Teacher {
  final String id;
  String name;
  String phone;
  final String profilePic;
  final String email;
  final TeacherRating rating;
  final int totalRating;
  String dateOfBirth;
  final String gender;
  College college;
  Course course;
  List<String> subjectsIds;
  final double balance;
  final bool isVerified;
  final String accountInfo;

  Teacher({
    required this.id,
    required this.name,
    required this.phone,
    required this.profilePic,
    required this.email,
    required this.rating,
    required this.subjectsIds,
    required this.dateOfBirth,
    required this.gender,
    required this.college,
    required this.course,
    required this.balance,
    required this.totalRating,
    required this.isVerified,
    required this.accountInfo,
  });

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
        'course': course.courseName,
        'rating': rating.toJson(),
        'totalRating': totalRating,
        'balance': balance,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isVerified': isVerified,
        'accountInfo': accountInfo,
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
      course: Course(courseId: json['course'], courseName: json['course']),
      isVerified: json['isVerified'] ?? false,
      accountInfo: json['accountInfo'] ?? '',
    );
  }

  Future<void> addOrUpdateTeacher(bool isEdit) async {
    print('${isEdit ? 'Update' : 'Create'} teacher');

    if (isEdit)
      await CollectionRef.teachers.doc(id).update(toJson(isEdit));
    else
      await CollectionRef.teachers.doc(id).set(toJson(isEdit));
  }

  static bool _hasTeacherData = false;
  static Future<bool> fetchIfExist(User user) async {
    if (_hasTeacherData) return true;

    final data = await CollectionRef.teachers.doc(user.uid).get();

    if (data.exists && data.data() != null) {
      UserData.teacher = Teacher.fromJson(data.data()!);
      _hasTeacherData = true;
      return true;
    }

    await _createNewTeacherDoc(user);

    _hasTeacherData = true;
    return false;
  }

  static Future<void> _createNewTeacherDoc(User user) async {
    final newTeacher = Teacher(
        id: user.uid,
        name: user.displayName ?? '',
        phone: user.phoneNumber ?? '',
        profilePic: user.photoURL ?? '',
        email: user.email ?? '',
        rating: TeacherRating(performance: 0, accuracy: 0, availability: 0),
        subjectsIds: [],
        dateOfBirth: '',
        gender: '',
        college: College(collegeName: '', collegeId: ''),
        course: Course(courseName: '', courseId: ''),
        balance: 0,
        totalRating: 0,
        isVerified: false,
        accountInfo: '');
    await newTeacher.addOrUpdateTeacher(false);
    UserData.teacher = newTeacher;
  }
}

class TeachersAssignments {
  final String id;
  final String assignmentId;
  final String teacherId;
  final double amount;
  final DateTime time;
  TeacherAssignmentStatus status;
  final TeacherRating? rating;
  final List<String> assignmentFiles;
  late final AssignmentData assignmentData;

  TeachersAssignments({
    required this.id,
    required this.assignmentId,
    required this.teacherId,
    required this.amount,
    required this.time,
    required this.status,
    this.rating,
    required this.assignmentFiles,
  });

  factory TeachersAssignments.fromJson(Map<String, dynamic> json) {
    return TeachersAssignments(
      id: json['id'],
      assignmentId: json['assignmentId'],
      teacherId: json['teacher'],
      amount: double.tryParse(json['amount'].toString()) ?? 0,
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

  Future<void> fetchAssignmentData() async {
    assignmentData = (await AssignmentData.getAssignmentFromId(assignmentId))!;
  }
}

/// assignment

enum AssignmentType { Session, Assignment }

const kAssignmentTypeEnumMap = {
  AssignmentType.Assignment: 'Assignment',
  AssignmentType.Session: 'Session',
};

class AssignmentData {
  final String id;
  String name;
  String description;
  Subject subject;
  AssignmentType assignmentType;
  DateTime time;
  List<String> referenceFiles;

  AssignmentData({
    required this.id,
    required this.name,
    required this.description,
    required this.subject,
    required this.assignmentType,
    required this.time,
    required this.referenceFiles,
  });

  static Future<AssignmentData?> getAssignmentFromId(String id) async {
    final subjects = await Subject.getSubjects();

    final d = await CollectionRef.assignments.doc(id).get();
    final Map<String, dynamic>? json = d.data();

    if (json == null) return null;

    return AssignmentData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      subject: subjects.where((element) => element.id == json['subject']).first,
      assignmentType: kAssignmentTypeEnumMap.entries
          .singleWhere((element) => element.value == json['assignmentType'])
          .key,
      time: (json['time'] as Timestamp).toDate(),
      referenceFiles: (json['referenceFiles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
