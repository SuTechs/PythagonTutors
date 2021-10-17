import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationManager {
  /// singleton
  static final NotificationManager _singleton = NotificationManager._internal();

  factory NotificationManager() {
    return _singleton;
  }

  NotificationManager._internal();

  /// logics

  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

  // static final FlutterLocalNotificationsPlugin
  //     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await FirebaseMessaging.instance
        .getToken(); // => temporary fix for onResume message
    // /// configuring the notification channel
    // await _flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(kChannel);

    /// on launch
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   print('initial message = ${initialMessage.notification.toString()}');
    // }

    /// on resume
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('clicked message = ${message.notification.toString()}');
    // });

    /// foreground message
    FirebaseMessaging.onMessage.listen((message) {
      print('message = $message');
      //
      final RemoteNotification? notification = message.notification;
      // final AndroidNotification? android = message.notification?.android;
      //
      // if (notification != null && android != null)
      //   _showLocalNotification(notification);

      if (notification != null)
        Get.snackbar(notification.title!, notification.body!);
    });

    // /// background message
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

// static void _showLocalNotification(RemoteNotification notification) {
//   _flutterLocalNotificationsPlugin.show(
//     notification.hashCode,
//     notification.title,
//     notification.body,
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         kChannel.id,
//         kChannel.name,
//         kChannel.description,
//       ),
//     ),
//   );
// }
}
