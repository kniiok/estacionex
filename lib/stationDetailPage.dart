// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/MqttHandler.dart';
import 'package:sensor_flutter_app/mapPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notificationsPage.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

class StationDetailPage extends StatefulWidget {
  const StationDetailPage({super.key, required this.stationName});
  final String stationName;

  @override
  State<StationDetailPage> createState() => _StationDetailPageState();
}

class _StationDetailPageState extends State<StationDetailPage> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stationName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPage()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: labelType,
            leading: showLeading
                ? FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Icon(Icons.add),
                  )
                : const SizedBox(),
            trailing: showTrailing
                ? IconButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    icon: const Icon(Icons.more_horiz_rounded),
                  )
                : const SizedBox(),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.sensors_outlined),
                selectedIcon: Icon(Icons.sensors),
                label: Text('Estación'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.adjust_outlined),
                selectedIcon: Icon(Icons.adjust),
                label: Text('Ajustes'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_2_outlined),
                selectedIcon: Icon(Icons.person_2),
                label: Text('Usuario'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(6),
              crossAxisSpacing: 6,
              mainAxisSpacing: 14,
              crossAxisCount: 2,
              children: [
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Temperatura',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: const Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                            return Icon(Icons.device_thermostat,
                                size: constraint.biggest.height / 3,
                                color: const Color.fromARGB(169, 244, 67, 54));
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'temp'),
                          const Text('°F'),
                        ],
                      ),
                    ),
                  ),
                ),
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Viento',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                                size: constraint.biggest.height / 3,
                                color: Colors.blue);
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'wind_speed_hi_last_2_min'),
                          const Text('km/h'),
                        ],
                      ),
                    ),
                  ),
                ),
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Última lluvia',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                                size: constraint.biggest.height / 3,
                                color: const Color.fromARGB(255, 15, 128, 220));
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'rain_rate_last_mm'),
                          const Text('mm'),
                        ],
                      ),
                    ),
                  ),
                ),
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Presión',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                                size: constraint.biggest.height / 3,
                                color: Color.fromARGB(255, 137, 98, 173));
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'bar_absolute'),
                          const Text('bar'),
                        ],
                      ),
                    ),
                  ),
                ),
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Humedad',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                                size: constraint.biggest.height / 3,
                                color: Color.fromARGB(255, 142, 64, 12));
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'hum'),
                          const Text('%'),
                        ],
                      ),
                    ),
                  ),
                ),
                TitledContainer(
                  titleColor: Colors.white,
                  title: 'Punto Rocío',
                  textAlign: TextAlignTitledContainer.Center,
                  fontSize: 14.0,
                  backgroundColor: Color.fromARGB(255, 108, 144, 174),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[100],
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
                            return Icon(Icons.dew_point,
                                size: constraint.biggest.height / 3,
                                color: Colors.blue);
                          }),
                          ListenerWidget(
                              stationName: widget.stationName,
                              parameter: 'dew_point'),
                          const Text('°F'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => ''),
        tooltip: 'Nueva Alerta',
        child: const Icon(Icons.circle_notifications),
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
    return ultMsj;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUltMsj(widget.stationName, widget.parameter),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data!.isNotEmpty) {
            return Text(
              snapshot.data!,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            );
          } else {
            return SizedBox(
                width: 16, height: 16, child: CircularProgressIndicator());
          }
        });
  }
}
