import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationService {
  static Future<void> initNotification() async {
    await AwesomeNotifications().isNotificationAllowed().then((
      isAllowed,
    ) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'notification_channel',
        channelName: 'Notification customization',
        channelDescription: 'Notification customization',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
      ),
    ]);
  }

  static Future<void> createNotificationGlobal({
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'notification_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
