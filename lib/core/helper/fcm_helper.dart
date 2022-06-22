// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:injectable/injectable.dart';

// import '../bloc/notification_updates/index.dart';
// import '../bloc/notification_updates/notification_updates_bloc.dart';
// import '../common/app_logger.dart';
// import 'notification_payload.dart';

// @singleton
// class FCMHelper {
//   FCMHelper(this._firebaseMessaging, this._logger, this._notificationUpdatesBloc);
//   final FirebaseMessaging _firebaseMessaging;
//   final AppLogger _logger;
//   final NotificationUpdatesBloc _notificationUpdatesBloc;

//   void requestPermission() {
//     _firebaseMessaging.requestPermission();
//   }

//   Future<String?> getToken() async {
//     _logger.debug(':: _firebaseMessaging :: getToken 1 :: ');
//     return _firebaseMessaging.getToken();
//   }

//   void setupFirebase({
//     required Function(String) onTokenGenerated,
//     required Function(NotificationPayload) onNotification,
//     required Function(NotificationPayload) onNotificationClicked,
//   }) {
//     /// fetch device token
//     _firebaseMessaging.getToken().then((String? token) {
//       _logger.debug(':: _firebaseMessaging :: getToken :: $token');
//       onTokenGenerated(token!);
//     });

//     /// handle notification in foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       _logger.debug(':: _firebaseMessaging :: FirebaseMessaging :: ${event.data}');
//       final NotificationPayload _notificationPayload = NotificationPayload(
//         id: int.parse(event.data['id'].toString()),
//         notificationId: int.parse(event.data['notificationId'].toString()),
//         title: event.notification?.title,
//         body: event.notification?.body,
//       );
//       _logger.debug(':: _firebaseMessaging :: FirebaseMessaging :: _notificationPayload :: $_notificationPayload');
//       _notificationUpdatesBloc.add(NotificationUpdatesEventNotify(notificationPayload: _notificationPayload));
//       onNotification(_notificationPayload);
//     });

//     /// handle notification when the user click on it
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
//       // onNotification(NotificationPayload.fromJson(event.data));
//     });

//     /// use it if want to run code int background
//     // FirebaseMessaging.onBackgroundMessage.listen((event) {
//     //   NotificationPayload notification =
//     //   _notificationPayloadMapper.fromJson(event.data);
//     //   onNotificationClicked(notification);
//     // });
//   }

//   static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//     // print(":: _firebaseMessaging :: BackgroundMessage : $message");
//     // onMessageClicked(message);
//     // if (message.containsKey('data')) {
//     //   // Handle data message
//     //   final dynamic data = message['data'];
//     //   _logger.log(":: _firebaseMessaging :: BackgroundMessage :: data: $myBackgroundMessageHandler");
//     // }

//     // if (message.containsKey('notification')) {
//     //   // Handle notification message
//     //   final dynamic notification = message['notification'];
//     //   _logger.log(":: _firebaseMessaging :: BackgroundMessage :: notification: $notification");
//     // }
//   }
// }
