// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotifiactionsServices {
//   final FlutterLocalNotificationsPlugin _flutterNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final AndroidInitializationSettings _androidInitializationSettings =
//       const AndroidInitializationSettings('logo');

//   void initialiseNotificatons() async {
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: _androidInitializationSettings,
//     );
//     await _flutterNotificationsPlugin.initialize(initializationSettings);
//   }

//   void sendNotifications(String title, String body) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       "channelId",
//       "channelName",
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );
//     _flutterNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
// }
