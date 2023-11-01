import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/stationDetailPage.dart';
import 'notificationsPage.dart';

class StationListPage extends StatefulWidget {
  const StationListPage({super.key});

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
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
                label: Text('Estaciones'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: Text('Mapa'),
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
            child: ListView(
              children: const [
                StationItem(name: 'Estación-123501'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                StationItem(name: 'Estación-167442'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                StationItem(name: 'Estación-138225'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                StationItem(name: 'Estación-145839'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                StationItem(name: 'Estación-145862'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
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
          MaterialPageRoute(
              builder: (context) => StationDetailPage(
                  stationName: name)), // Pasar pt como argumento
        );
      },
      child: ListTile(title: Text(name)),
    );
  }
}
