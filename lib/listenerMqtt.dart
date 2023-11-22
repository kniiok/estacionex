import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/MqttHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Text(value=='null'||value=='NaN'?"-":value,
                  style: const TextStyle(color: Colors.black, fontSize: 18))
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
    return ultMsj=='null'||ultMsj=='NaN'?"-":ultMsj;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: getUltMsj(widget.stationName, widget.parameter),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data!.isNotEmpty) {
            return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    snapshot.data!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )
                ]);
          } else {
                return Text("- ");
          }
        });
  }
}
