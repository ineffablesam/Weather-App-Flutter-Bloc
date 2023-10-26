import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void initializeAwesomeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'weather_app_channel',
          channelName: 'Weather App',
          channelDescription:
              'Notification channel for weather app for Testing purpose',
          defaultColor: Colors.deepOrangeAccent,
          ledColor: Colors.deepOrange,
          playSound: true,
          enableVibration: true,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  static sendNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'weather_app_channel',
            title: '🥶ITS COLD OUTSIDE',
            summary:
                'Take a jacket with you, it is 5 degrees celsius outside right now',
            body:
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.',
            actionType: ActionType.KeepOnTop,
            notificationLayout: NotificationLayout.Default,
          ),
          actionButtons: [
            NotificationActionButton(
              key: 'OPEN',
              label: 'Take Action',
              enabled: true,
              actionType: ActionType.KeepOnTop,
              icon: 'resource://drawable/res_ic_notification',
            ),
            NotificationActionButton(
              key: 'OPEN',
              label: 'Ignore',
              enabled: true,
              color: Colors.red,
              actionType: ActionType.KeepOnTop,
              icon: 'resource://drawable/res_ic_notification',
            ),
            NotificationActionButton(
              key: 'OPEN',
              label: 'Share with Friends',
              enabled: true,
              color: Colors.red,
              actionType: ActionType.KeepOnTop,
              icon: 'resource://drawable/res_ic_notification',
            ),
            NotificationActionButton(
              key: 'OPEN',
              label: 'Call Developer',
              enabled: true,
              color: Colors.red,
              actionType: ActionType.KeepOnTop,
              icon: 'resource://drawable/res_ic_notification',
            ),
            NotificationActionButton(
              key: 'OPEN',
              label: 'Custom Action',
              enabled: true,
              color: Colors.red,
              actionType: ActionType.KeepOnTop,
              icon: 'resource://drawable/res_ic_notification',
            ),
          ],
        );
      }
    });
  }
}
