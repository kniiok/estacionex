import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked_notification_cards/stacked_notification_cards.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: const Center(
        child: NotificationPage(),
      ),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

SqliteService sqliteService = SqliteService();

class _NotificationPageState extends State<NotificationPage> {
  late SqliteService _sqliteService;

  @override
  void initState() {
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initializeDB().whenComplete(() async {
      _getAlarms();
      setState(() {});
    });
  }

  List<Alarm> _alarms = [];
  final List<NotificationCard> listAlarms = [];

// This function is used to fetch all data from the database
  void _getAlarms() async {
    final data = await _sqliteService.getItems();

    setState(() {
      _alarms = data;
      for (var alarm in _alarms) {
        var stationName = '';
        switch (alarm.station.substring(9, 15)) {
          case '123501':
            stationName = 'Cielos Del Sur';
            break;
          case '138225':
            stationName = 'Glyn';
            break;
          case '145839':
            stationName = 'Villa Favaloro';
            break;
          case '145862':
            stationName = 'Las Santinas Virch';
            break;
          case '167442':
            stationName = 'Glyn 3';
            break;
          default:
            stationName = '';
            break;
        }
        listAlarms.add(NotificationCard(
          date: DateTime.now(),
          leading: Icon(
            Icons.warning,
            size: 48,
          ),
          title: alarm.id.toString(),
          subtitle: stationName + ' \n' + alarm.data,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StackedNotificationCards(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.0,
                )
              ],
              notificationCardTitle: 'Alerta',
              notificationCards: [...listAlarms],
              cardColor: Color.fromARGB(255, 250, 237, 192),
              padding: 16,
              actionTitle: Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              showLessAction: Text(
                'Mostrar menos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 102, 75, 236),
                ),
              ),
              clearAllNotificationsAction:
                  Icon(Icons.keyboard_arrow_up_outlined),
              clearAllStacked: Text('limpiar todo'),
              cardClearButton: Text('limpiar'),
              cardViewButton: Text('volver'),
              onTapClearCallback: (index) {
                print(index);
                setState(() {
                  var alarm =
                      sqliteService.getItem(int.parse(listAlarms[index].title));

                  sqliteService.deleteFutureItem(alarm);
                  listAlarms.removeAt(index);
                });
              },
              onTapClearAll: () {
                setState(() {
                  for (var alarm in _alarms) {
                    alarm.state = 0;
                    sqliteService.deleteItem(alarm);
                  }
                  listAlarms.clear();
                });
              },
              onTapViewCallback: (index) {
                print(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Alarm {
  final int id;
  final String station;
  final String data;
  int state;

  Alarm({
    required this.id,
    required this.station,
    required this.data,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'station': station, 'data': data, 'state': state};
  }

  Alarm.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        station = item["station"],
        data = item["data"],
        state = item["state"];
  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Alarm{id: $id, station: $station, data: $data, state: $state}';
  }
}

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'alarms.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE alarms(id INTEGER PRIMARY KEY AUTOINCREMENT, station TEXT NOT NULL, data TEXT, state INT)",
        );
      },
      version: 1,
    );
  }

  Future<int> createItem(Alarm alarm) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert('alarms', alarm.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Alarm>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('alarms', where: "state = 1");
    return queryResult.map((e) => Alarm.fromMap(e)).toList();
  }

  Future<Alarm> getItem(int id) async {
    var list = [];
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('alarms', where: "id = ?", whereArgs: [id]);
    list = queryResult.map((e) => Alarm.fromMap(e)).toList();

    return list[0];
  }

  // Delete an note by id
  Future<void> deleteItem(Alarm alarm) async {
    final db = await initializeDB();

    try {
      await db.update("alarms", alarm.toMap(),
          where: "id = ?", whereArgs: [alarm.id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<void> deleteFutureItem(Future<Alarm> alarm) async {
    final db = await initializeDB();
    final alarma = await alarm;
    alarma.state = 0;
    try {
      await db.update("alarms", alarma.toMap(),
          where: "id = ?", whereArgs: [alarma.id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
