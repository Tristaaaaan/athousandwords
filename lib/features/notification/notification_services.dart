import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod/riverpod.dart';

final messageServicesProvider = StateProvider<FirebaseMessage>((ref) {
  return FirebaseMessage();
});

// void showNotification(RemoteMessage message) {
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: message.messageId.hashCode,
//       channelKey: 'high_importance_channel',
//       title: message.notification?.title,
//       body: message.notification?.body,
//     ),
//   );
// }

class FirebaseMessage {
  final firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> initNotifications() async {
  //   await firebaseMessaging.requestPermission();

  //   NotificationSettings settings = await firebaseMessaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }

  //   AwesomeNotifications().initialize(
  //     'resource://drawable/suri_notif_icon',
  //     [
  //       NotificationChannel(
  //           channelKey: 'alerts',
  //           channelName: 'Alerts',
  //           channelDescription: 'Notification tests as alerts',
  //           playSound: true,
  //           onlyAlertOnce: true,
  //           groupAlertBehavior: GroupAlertBehavior.Children,
  //           importance: NotificationImportance.High,
  //           defaultPrivacy: NotificationPrivacy.Private,
  //           defaultColor: Colors.deepPurple,
  //           ledColor: Colors.deepPurple)
  //     ],
  //   );

  //   AwesomeNotifications().isNotificationAllowed().then(
  //     (isAllowed) {
  //       if (!isAllowed) {
  //         // Request permission to send notifications
  //         AwesomeNotifications().requestPermissionToSendNotifications().then(
  //           (isAllowed) {
  //             if (isAllowed) {
  //               devtools.log('User allowed notifications');
  //             } else {
  //               devtools.log('User denied notifications');
  //             }
  //           },
  //         );
  //       }
  //     },
  //   );

  //   await firebaseMessaging.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   FirebaseMessaging.onMessage.listen(
  //     (RemoteMessage message) async {
  //       if (message.notification != null) {
  //         int id = Random().nextInt(1000000);

  //         await AwesomeNotifications().createNotification(
  //           content: NotificationContent(
  //               id: id,
  //               channelKey: 'alerts',
  //               title: message.data['title'],
  //               body: message.data['body'],
  //               bigPicture: "${message.data['imageUrl']}",
  //               notificationLayout: NotificationLayout.BigPicture,
  //               payload: {}),
  //           actionButtons: [
  //             NotificationActionButton(
  //                 key: 'VIEW',
  //                 label: 'View',
  //                 actionType: ActionType.SilentAction),
  //             NotificationActionButton(
  //                 key: 'DISMISS',
  //                 label: 'Dismiss',
  //                 actionType: ActionType.DismissAction,
  //                 isDangerousOption: true)
  //           ],
  //         );
  //       }
  //     },
  //   );

  //   // When Application is in the Background but not terminated
  //   FirebaseMessaging.onMessageOpenedApp.listen(
  //     (RemoteMessage message) async {},
  //   );
  // }

  Future<String?> getFCMToken() async {
    if (Platform.isAndroid) {
      return await firebaseMessaging.getToken();
    }
    return null;
  }

  // Future<bool> sendPushMessage({
  //   required String recipientToken,
  //   required String title,
  //   required String body,
  //   required String route,
  //   String? classId,
  //   String? tutorId,
  // }) async {
  //   String path;
  //   String senderId;
  //   if (AppConfig.environment == Flavors.production) {
  //     path = 'lib/structure/messaging/ServiceAccountKeyProduction.json';

  //     senderId = '378925058177';
  //   } else {
  //     path = 'lib/structure/messaging/ServiceAccountKeyDevelopment.json';
  //     senderId = '188110141525';
  //   }

  //   String credentialsJson = await rootBundle.loadString(path);

  //   Map<String, dynamic> credentials = json.decode(credentialsJson);
  //   final client = await clientViaServiceAccount(
  //     ServiceAccountCredentials.fromJson(credentials),
  //     ['https://www.googleapis.com/auth/cloud-platform'],
  //   );

  //   final notificationData = {
  //     'message': {
  //       'token': recipientToken,
  //       'notification': {
  //         'title': title,
  //         'body': body,
  //       },
  //     },
  //   };

  //   final response = await client.post(
  //     Uri.parse(
  //         'https://fcm.googleapis.com/v1/projects/$senderId/messages:send'),
  //     headers: {
  //       'content-type': 'application/json',
  //     },
  //     body: jsonEncode(notificationData),
  //   );

  //   client.close();
  //   if (response.statusCode == 200) {
  //     return true;
  //   }

  //   devtools.log(
  //       'Notification Sending Error Response status: ${response.statusCode}');
  //   devtools.log('Notification Response body: ${response.body}');
  //   return false;
  // }
}
