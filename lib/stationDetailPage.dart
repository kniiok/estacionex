import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/MqttHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MqttHandler.dart';

class StationDetailPage extends StatefulWidget {
  const StationDetailPage({super.key, required this.stationName});
  final String stationName;

  @override
  State<StationDetailPage> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends State<StationDetailPage> {
  MqttHandler mqttHandler = MqttHandler();




  @override
  void initState() {
    super.initState();
    mqttHandler.connect(widget.stationName);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stationName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Temperatura Actual: ',
                style: TextStyle(color: Colors.black, fontSize: 25)),
            ValueListenableBuilder<String>(
              builder: (BuildContext context, String value, Widget? child) {
                if(value.isEmpty){
                  return MyWidget();
                }else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(value,
                          style: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 15
                          )
                      )
                    ],
                  );
                }
              },
              valueListenable: mqttHandler.data,
            ),
    ],
        ),
      ),
    );
  }

}
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});



  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var prefs;

  @override
  void initState() {
    super.initState();
    getUltMsj();
  }

  Future<String> getUltMsj() async {
    prefs = await SharedPreferences.getInstance();
    final ultMsj = prefs.getString('ultMsj-$stationName') ?? '';
    return ultMsj;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getUltMsj(),
        builder: (context, AsyncSnapshot<String> snapshot) {
            return
              Text(snapshot.data!,
                style: TextStyle(color: Colors.black, fontSize: 25),
          );
        }
    );
  }
}