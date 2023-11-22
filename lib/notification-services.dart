import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:sensor_flutter_app/main.dart';
import 'package:sensor_flutter_app/notificationsPage.dart';
import 'package:sensor_flutter_app/stationListPage.dart';





final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid = 
  AndroidInitializationSettings('@mipmap/ic_launcher');

const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();


  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

}
 Future<void> showNotification(String data) async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('chanel_id', 'chanel_name', importance: Importance.max, priority: Priority.max);

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails
    );
    dynamic dataObject = jsonDecode(data);
    await flutterLocalNotificationsPlugin.show(1, 'Alarma de Clima',  dataObject['topic'], notificationDetails);
    Alarm alarm = Alarm(id: UniqueKey().hashCode, station: dataObject['topic'], data: dataObject['data'].toString(), state: 1);
    sqliteService.createItem(alarm);
    updateNotifications();
   
 }

