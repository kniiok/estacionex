import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sensor_flutter_app/notificationsPage.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Mapa de Estaciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(-43.86413, -68.49656),
        initialZoom: 5.5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(-43.31946, -65.46399),
              width: 80,
              height: 80,
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(children: <Widget>[
                  Text('Gaiman-Chubut',
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('FrutosVirch'),
                          content: Container(
                              height: 140,
                              child: Column(children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Estación Cielos del Sur',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Divider(),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Id Estación: 123501')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Latitud: -43.31946')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Longitud: -65.46399')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Elevación: 51.255'))
                              ])),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253),
                    ),
                  ),
                ]);
              }),
            ),
            Marker(
              point: LatLng(-43.29987, -65.41184),
              width: 80,
              height: 80,
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(children: <Widget>[
                  Text('Trelew-Chubut',
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('FrutosVirch'),
                          content: Container(
                              height: 140,
                              child: Column(children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Estación Glyn',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Divider(),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Id Estación: 138225')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Latitud: -43.29987')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Longitud: -65.41184')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Elevación: 48.561504'))
                              ])),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253),
                    ),
                  ),
                ]);
              }),
            ),
            Marker(
              point: LatLng(-46.528656, -71.66152),
              width: 80,
              height: 80,
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(children: <Widget>[
                  Text('Los Antiguos-Santa Cruz',
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('FrutosVirch'),
                          content: Container(
                              height: 140,
                              child: Column(children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Estación Villa Favaloro',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Divider(),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Id Estación: 145839')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Latitud: -46.528656')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Longitud: -71.66152')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Elevación: 84.97272'))
                              ])),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253),
                    ),
                  ),
                ]);
              }),
            ),
            Marker(
              point: LatLng(-43.27398, -65.38564),
              width: 80,
              height: 80,
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(children: <Widget>[
                  Text('Trelew-Chubut',
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('FrutosVirch'),
                          content: Container(
                              height:140,
                              child: Column(children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Estación Las Santinas VIRCH',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Divider(),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Id Estación: 145862')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Latitud: -43.27398')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Longitud: -65.38564')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Elevación: 42.403'))
                              ])),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253),
                    ),
                  ),
                ]);
              }),
            ),
            Marker(
              point: LatLng(-43.313225, -65.47385),
              width: 80,
              height: 80,
              child: LayoutBuilder(builder: (context, constraint) {
                return Column(children: <Widget>[
                  Text('Gaiman-Chubut',
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('FrutosVirch'),
                          content: Container(
                              height: 140,
                              child: Column(children: <Widget>[
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Estación Glyn 3',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Divider(),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Id Estación: 167442')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Latitud: -43.313225')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Longitud: -65.47385')),
                                Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Elevación: 50.649'))
                              ])),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253),
                    ),
                  ),
                ]);
              }),
            ),
          ],
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    ));
  }
}
