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
    if(dataObject['data']['temp']!=null){
      dataObject['data']['temp'] = (((dataObject['data']['temp'] - 32)*5/9).toStringAsFixed(1)).toString();
    }
    if(dataObject['data']['dew_point']!=null){
      dataObject['data']['dew_point'] = (((dataObject['data']['dew_point'] - 32)*5/9).toStringAsFixed(1)).toString();
    }
    if(dataObject['data']['wind_speed_hi_last_2_min']!=null){
      dataObject['data']['wind_speed_hi_last_2_min'] = ((dataObject['data']['wind_speed_hi_last_2_min']*1.60934).toStringAsFixed(1)).toString();
    }
    var stationName='';
    switch (dataObject['topic'].toString().substring(10, 16)) {
      case '123501':
        stationName='Cielos Del Sur';
        break;
      case '138225':
        stationName='Glyn';
        break;
      case '145839':
        stationName='Villa Favaloro';
        break;
      case '145862':
        stationName='Las Santinas Virch';
        break;
      case '167442':
        stationName='Glyn 3';
        break;
      default:
      stationName='';
      break;
    }
    Alarm alarm = Alarm(id: UniqueKey().hashCode, station: utf8.decode(dataObject['topic'].codeUnits), data: dataObject['data'].toString().substring(1, dataObject['data'].toString().length-1), state: 1);
    sqliteService.createItem(alarm);
    updateNotifications();
   
 }

