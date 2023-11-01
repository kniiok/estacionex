import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
                  Icon(Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253)),
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
                  Icon(Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253)),
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
                  Icon(Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253)),
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
                  Icon(Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253))
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
                  Icon(Icons.sensors,
                      size: constraint.biggest.height / 2,
                      color: Color.fromARGB(169, 55, 180, 253))
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
    );
  }
}
