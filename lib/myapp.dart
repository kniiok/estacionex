import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:sensor_flutter_app/page_header.dart';
import 'package:sensor_flutter_app/stationListPage.dart';
import 'package:provider/provider.dart';
import 'package:sensor_flutter_app/model_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> attemptLogin(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final String username = usernameController.text;
    final String password = passwordController.text;

    final client = MqttServerClient('150.230.80.1', '1883');
    client.logging(on: false);

    final connMess = MqttConnectMessage()
        .withClientIdentifier('dart_client')
        .withWillTopic('test_topic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .authenticateAs(username, password);

    client.connectionMessage = connMess;

    try {
      await client.connect();
      setState(() {
        isLoading = false;
      });
      // La conexión fue exitosa, puedes redirigir al usuario a la página deseada
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StationListPage()),
      );
    } on NoConnectionException catch (e) {
      print('Client exception: $e');
      client.disconnect();
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error de autenticación"),
            content: Text("Usuario o contraseña incorrectos."),
            actions: <Widget>[
              TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } on SocketException catch (e) {
      print('Socket exception: $e');
      client.disconnect();
      // Muestra un mensaje de error al usuario u otra acción en caso de fallo
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error de conexión"),
              content: Text("No se pudo conectar al servidor."),
              actions: <Widget>[
                TextButton(
                  child: Text("Aceptar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new PageHeader(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para verificar las credenciales
                attemptLogin(context);
              },
              child: Text('Iniciar Sesión'),
            ),
            isLoading ? CircularProgressIndicator() : Text('')
          ],
        ),
      ),
    );
  }
}
