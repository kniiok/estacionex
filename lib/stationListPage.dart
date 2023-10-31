import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/stationDetailPage.dart';
import 'notificationsPage.dart';

class StationListPage extends StatelessWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Estaciones'),
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
      body: ListView(
        children: const [
          StationItem(name: 'Estación-123501'),
          StationItem(name: 'Estación-167442'),
          StationItem(name: 'Estación-138225'),
          StationItem(name: 'Estación-145839'),
          StationItem(name: 'Estación-145862'),
        ],
      ),
    );
  }
}

class StationItem extends StatelessWidget {
  final String name;

  const StationItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StationDetailPage(stationName: name)), // Pasar pt como argumento
        );
      },
      child: ListTile(title: Text(name)),
    );
  }
}
