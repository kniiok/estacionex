import 'package:sensor_flutter_app/notificationsPage.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:sensor_flutter_app/DBConnection.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    Database().openConnection();
   
  }

  @override
  Widget build(BuildContext context) {
    var newPasswordController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // ListView.builder(
          //   itemCount: users.length,
          //   itemBuilder: (context, index) {
          //     final user = users[index];
          //     return ListTile(
          //       title: Text(user.username),
          //       subtitle: Text(user.password),
          //     );
          //   },
          // ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Cambio de Contraseña')),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Llama a la función para verificar las credenciales
              // DBConnection dbConnection= DBConnection();
              // dbConnection.getConnection();
              // late Db db;
              // Future<Db> getConnection() async {
              //   try {
              //     db = Db(
              //         'mongodb://sistemas_distribuidos:j2CTTKqbZaNyQqsd@150.230.80.1:27017/?retryWrites=true&w=majority/mqtt_auth');
              //     await db.open();
              //   } catch (e) {
              //     print(e);
              //   }

              //   return db;
              // }
              // var users=getConnection().whenComplete(() => db.collection('users'));
              // print('esta');
              // print(users);
              //print(users);

              //print(Database().getDbState());
             
              print(Database().isConnected());
             
       
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

class User {
  final String id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<dynamic, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
        id: id, username: map['username'], password: map['password_hash']);
  }
}

// class UserListScreen extends StatefulWidget {
//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   List<User> users = [];

//   @override
//   void initState() {
//     super.initState();
//     _getUsers();
//   }

//   Future<void> _getUsers() async {
//     final List<Map<String, dynamic>> data =
//         await Database().users.find().toList();
//     setState(() {
//       users = data
//           .map((userData) =>
//               User.fromMap(userData, userData['username'].toString()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             title: Text(user.username as String),
//             subtitle: Text(user.password),
//           );
//         },
//       ),
//     );
//   }
// }
