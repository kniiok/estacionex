import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/configPage.dart';
import 'package:sensor_flutter_app/mapPage.dart';
import 'package:sensor_flutter_app/stationDetailPage.dart';
import 'package:sensor_flutter_app/userPage.dart';
import 'notificationsPage.dart';
import 'package:sensor_flutter_app/MqttHandlerAlarm.dart';

class StationListPage extends StatefulWidget {
  const StationListPage({super.key});

  @override
  State<StationListPage> createState() => _StationListPageState();

}
var counter= 0;
updateNotifications() async {
  List<Alarm> items = await sqliteService.getItems();
  counter = items.length;
  return items.length;
}
class _StationListPageState extends State<StationListPage> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;
  MqttHandlerAlarm mqttHandler = MqttHandlerAlarm();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect();
    updateNotifications();
    print('CANTIDAD DE ALARMAS:');
    print(counter);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Estaciones'), actions: [
        Stack(
    children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationsPage()),
            );
          },
        ),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 5, left:8),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: Text(
                  counter.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        )]),
      ]),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigPage()),
                  );
                }
                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                }
              });
            },
            labelType: labelType,
            leading: showLeading
                ? FloatingActionButton(
                    elevation: 0,
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  )
                : const SizedBox(),
            trailing: showTrailing
                ? IconButton(
                    onPressed: () {},
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
                Text('Gaiman-Chubut/(Cielos del Sur)'),
                StationItem(name: 'Estación-123501-Sensor-525320'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Cielos del Sur)'),
                StationItem(name: 'Estación-123501-Sensor-525321'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Cielos del Sur)'),
                StationItem(name: 'Estación-123501-Sensor-525322'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Cielos del Sur)'),
                StationItem(name: 'Estación-123501-Sensor-462216'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Cielos del Sur)'),
                StationItem(name: 'Estación-123501-Sensor-464200'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Glyn 3)'),
                StationItem(name: 'Estación-167442-Sensor-650013'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Glyn 3)'),
                StationItem(name: 'Estación-167442-Sensor-650015'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Gaiman-Chubut/(Glyn 3)'),
                StationItem(name: 'Estación-167442-Sensor-653139'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Glyn)'),
                StationItem(name: 'Estación-138225-Sensor-525326'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Glyn)'),
                StationItem(name: 'Estación-138225-Sensor-525327'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Glyn)'),
                StationItem(name: 'Estación-138225-Sensor-525170'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Los Antiguos-Santa Cruz/(Villa Favaloro)'),
                StationItem(name: 'Estación-145839-Sensor-557448'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Los Antiguos-Santa Cruz/(Villa Favaloro)'),
                StationItem(name: 'Estación-145839-Sensor-653825'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Los Antiguos-Santa Cruz/(Villa Favaloro)'),
                StationItem(name: 'Estación-145839-Sensor-653824'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Los Antiguos-Santa Cruz/(Villa Favaloro)'),
                StationItem(name: 'Estación-145839-Sensor-653826'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Las Santinas VIRCH)'),
                StationItem(name: 'Estación-145862-Sensor-558414'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Las Santinas VIRCH)'),
                StationItem(name: 'Estación-145862-Sensor-557537'),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Text('Trelew-Chubut/(Las Santinas VIRCH)'),
                StationItem(name: 'Estación-145862-Sensor-653141'),
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
