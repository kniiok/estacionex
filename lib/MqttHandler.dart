// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MqttHandler with ChangeNotifier {
  final ValueNotifier<String> data = ValueNotifier<String>("");
  late MqttServerClient client;

  Future<Object> connect(stationId, parameter) async {
    client = MqttServerClient.withPort(
        '150.230.80.1', 'station:$stationId-parameter:$parameter', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.logging(on: true);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .authenticateAs('Tomas', '1234');

    print('Connecting....');

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      return -1;
    }
    var sensor = '';
    switch (stationId) {
      case 'Estación-123501':
        sensor = 'Sensor-464200';
        break;
      case 'Estación-167442':
        sensor = 'Sensor-650015';
        break;
      case 'Estación-138225':
        sensor = 'Sensor-525327';
        break;
      case 'Estación-145839':
        sensor = 'Sensor-653828';
        break;
      case 'Estación-145862':
        sensor = 'Sensor-653141';
        break;
    }

    final topic = '$stationId-$sensor/$parameter';
    print('Subscribing to the $topic topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      data.value = pt;
      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();
      // set value
      await prefs.setString('ultMsj-$stationId-$parameter', data.value);
      //print('Set-ultMsj-$stationId-$parameter');
      notifyListeners();
      print('New data arrived: topic is <${c[0].topic}>, payload is $pt');
      print('');
    });

    return client;
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  void pong() {
    print('Ping response client callback invoked');
  }

  /*void publishMessage(String message) {
    const pubTopic = 'test/sample';
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
    }
  }*/
}
