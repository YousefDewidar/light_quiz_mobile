import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:light_quiz/core/helper/di.dart';
import 'package:light_quiz/core/widgets/layout_view.dart';
import 'package:light_quiz/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? fcmToken;

class FcmHelper {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    String? fcmToken = await _firebaseMessaging.getToken();
    getIt.get<SharedPreferences>().setString('fcmToken', fcmToken!);
    handleBackgroundNotification();
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => LayoutView()),
    );
  }

  Future<void> handleBackgroundNotification() async {
    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
