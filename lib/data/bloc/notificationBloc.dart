import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '/data/utils/modal/collectionRef.dart';
import '/data/utils/modal/user.dart';
import '../database.dart';

class NotificationListController extends GetxController {
  final notifications = <NotificationData>[].obs;

  @override
  void onInit() {
    super.onInit();

    CollectionRef.notifications
        .where('to', whereIn: [UserData.teacher.id, 'tutors'])
        .snapshots()
        .listen((snapshot) {
          _handleData(snapshot.docs);
        });
  }

  void _handleData(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    final List<NotificationData> a = [];

    /// parsing and fetching data
    try {
      for (QueryDocumentSnapshot<Map<String, dynamic>> q in docs) {
        final t = NotificationData.fromJson(q.data());
        a.add(t);
      }
    } catch (e) {
      print('Error #23221 $e');
    }

    /// adding data

    if (notifications.isNotEmpty) notifications.clear();
    notifications.addAll(a);

    // update();
  }
}
