import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  void onInit() {
    super.onInit();
    initializeFCM();
  }

  void initializeFCM() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    String? token = await firebaseMessaging.getToken();
    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.messageId}');
      if (message.notification != null) {
        Get.snackbar(
          message.notification!.title ?? 'Notification',
          message.notification!.body ?? '',
        );
      }

      firebaseAnalytics.logEvent(
        name: 'message_received',
        parameters: {
          'message_id': message.messageId ?? '',
          'message_title': message.notification?.title ?? '',
          'message_body': message.notification?.body ?? '',
        },
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened by notification: ${message.messageId}');
    });
  }
}
