// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/MqttHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationDetailPage extends StatefulWidget {
  const StationDetailPage({super.key, required this.stationName});
  final String stationName;

  @override
  State<StationDetailPage> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends State<StationDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stationName),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(4),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        crossAxisCount: 2,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.brightness_5_outlined,
                        size: constraint.biggest.height / 3);
                  }),
                  ListenerWidget(
                      stationName: widget.stationName, parameter: 'temp'),
                      const Text('F'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.air,
                        size: constraint.biggest.height / 3);
                  }),
                  ListenerWidget(
                      stationName: widget.stationName,
                      parameter: 'wind_speed_hi_last_2_min'),
                      const Text('km/h'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.air, size: constraint.biggest.height / 3);
                  }),
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.arrow_forward_ios,
                        size: constraint.biggest.height / 6);
                  }),
                 ListenerWidget(
                      stationName: widget.stationName,
                      parameter: 'wind_dir_at_hi_speed_last_2_min'),
                      const Text('°'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.vertical_align_bottom,
                        size: constraint.biggest.height / 3);
                  }),
                  ListenerWidget(
                      stationName: widget.stationName, parameter: 'dew_point'),
                      const Text('bar'),
                ],
                
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.water_damage,
                        size: constraint.biggest.height / 3);
                  }),
                 ListenerWidget(
                      stationName: widget.stationName, parameter: 'hum'),
                      const Text('%'),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
             child: Center(
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraint) {
                    return Icon(Icons.water_drop_outlined,
                        size: constraint.biggest.height / 3);
                  }),
                 ListenerWidget(
                      stationName: widget.stationName, parameter: 'rain_rate_last_mm'),
                      const Text('mm'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListenerWidget extends StatefulWidget {
  const ListenerWidget(
      {super.key, required this.stationName, required this.parameter});
  final String stationName;
  final String parameter;

  @override
  _ListenerWidgetState createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect(widget.stationName, widget.parameter);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      builder: (BuildContext context, String value, Widget? child) {
        if (value.isEmpty) {
          return MyWidget(
            stationName: widget.stationName,
            parameter: widget.parameter,
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(value,
                   style: const TextStyle(color: Colors.black, fontSize: 25))
            ],
          );
        }
      },
      valueListenable: mqttHandler.data,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget(
      {super.key, required this.stationName, required this.parameter});
  final String stationName;
  final String parameter;

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // ignore: prefer_typing_uninitialized_variables
  var prefs;

  @override
  void initState() {
    super.initState();
    getUltMsj(widget.stationName, widget.parameter);
  }

  Future<String> getUltMsj(stationName, parameter) async {
    prefs = await SharedPreferences.getInstance();
    final ultMsj = prefs.getString('ultMsj-$stationName-$parameter') ?? '';
    //print('Get-$ultMsj');
    return ultMsj;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUltMsj(widget.stationName, widget.parameter),
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Text(
            snapshot.data!,
            style: const TextStyle(color: Colors.black, fontSize: 25),
          );
        });
  }
}
