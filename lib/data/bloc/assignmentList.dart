import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '/data/utils/modal/collectionRef.dart';
import '/data/utils/modal/user.dart';
import '../database.dart';

class AssignmentListController extends GetxController {
  // final RxList<TeachersAssignments> teacherAssignments =
  //     <TeachersAssignments>[].obs;

  // final List<TeachersAssignments> teacherAssignments = [];

  static final teacherAssignments = <TeachersAssignments>[].obs;

  @override
  void onInit() {
    super.onInit();

    CollectionRef.teachersAssignments
        .where('teacher', isEqualTo: UserData.teacher.id)
        // .where('teacher', isEqualTo: '+91 7667323338')
        .snapshots()
        .listen((snapshot) {
      _handleData(snapshot.docs);
    });
  }

  static void _handleData(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    final List<TeachersAssignments> a = [];

    /// parsing and fetching data
    try {
      for (QueryDocumentSnapshot<Map<String, dynamic>> q in docs) {
        final t = TeachersAssignments.fromJson(q.data());
        await t.fetchAssignmentData();
        a.add(t);
      }
    } catch (e) {
      print('Error #23221 $e');
    }

    /// adding data

    if (teacherAssignments.isNotEmpty) teacherAssignments.clear();
    teacherAssignments.addAll(a);

    print('Updated');

    // update();
  }
}

// class AssignmentListBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => AssignmentListController());
//   }
// }
