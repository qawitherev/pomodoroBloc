import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/utils/our_constants.dart';

class LocalNotification {
  late final FlutterLocalNotificationsPlugin notificationsPlugin;

  static final LocalNotification _localNotificationSingleton = LocalNotification
      ._internal();

  factory LocalNotification() {
    return _localNotificationSingleton;
  }

  LocalNotification._internal() {
    notificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initLocalNotification() async {
    const androidInitSettings = AndroidInitializationSettings('app_icon');
    const initSettings = InitializationSettings(
      android: androidInitSettings,
    );
    await notificationsPlugin.initialize(initSettings);
  }

  void showNotification() {
    const androidNotificationDetails = AndroidNotificationDetails(
      NotificationConstants.channelId,
      NotificationConstants.channelName,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      ticker: 'Pomodoro Running',
    );
    const notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    notificationsPlugin.show(
        0, "Pomodoro Running", "Is now running", notificationDetails);
    //TODO: to make this inside pomodoro provider
  }
}