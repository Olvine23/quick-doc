import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications_empty.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Notify {
 

  static Future<bool> instantNotify() async {
       
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(
        content: NotificationContent(
            title: "Instant notif",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt urna scelerisque, convallis sem sodales, dignissim nibh. Vestibulum non ante eget est lacinia gravida eget sed ipsum. Vestibulum mollis justo sem, eget pellentesque mauris interdum ac. Aenean varius vel erat a posuere. Curabitur suscipit scelerisque congue. Nam venenatis dolor velit, in cursus lacus laoreet ut. Etiam feugiat turpis nulla, vitae vestibulum felis tempus ut. Phasellus finibus purus",
            bigPicture: 'asset://assets/images/vid.png',
            notificationLayout: NotificationLayout.BigPicture,
            id: Random().nextInt(100),
            wakeUpScreen: true,
            channelKey: 'instant_notification'));
  }

  static Future<bool> schedulenotify() async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

    return await awesomeNotifications.createNotification(
        schedule: NotificationCalendar(
            day: 5, month: 2, year: 2023, hour: 15, minute: 17),
        content: NotificationContent(
            id: Random().nextInt(100),
            title: "Remind me",
            body: "Water your plant regularly to keep it healthy",
            wakeUpScreen: true,
            channelKey: 'scheduled_notification'));
  }
}
