import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _countdown = 10; // Başlangıçta 10 saniye geri sayım

  @override
  void initState() {
    super.initState();
    _initializeTimeZones();
    _initializeNotifications();
    _startCountdown();
  }

  void _initializeTimeZones() {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation('Europe/Istanbul')); // Zaman diliminizi buraya girin
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Bildirim Kanalını oluşturun (Android için)
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      'weather_notification_channel', // Kanal ID
      'Weather Notifications', // Kanal adı
      description: 'Weather-related notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
        _startCountdown();
      } else {
        _sendNotification();
      }
    });
  }

  void _sendNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'weather_notification_channel',
      'Weather Notifications',
      channelDescription: 'Weather-related notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hava Durumu Hatırlatması',
      'Hava bugün 10 derece, yağmurlu olacak, şemsiye almayı unutma!',
      notificationDetails,
      payload: 'weather_notification_payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notification Page'),
      ),
      body: Center(
        child: Text(
          '$_countdown saniye kaldı!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
