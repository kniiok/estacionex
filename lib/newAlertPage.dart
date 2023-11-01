import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sensor_flutter_app/page_header.dart';
import 'package:sensor_flutter_app/stationListPage.dart';

class NewAlertPage extends StatefulWidget {
  @override
  _NewAlertPageState createState() => _NewAlertPageState();
}

class _NewAlertPageState extends State<NewAlertPage> {
  final TextEditingController windController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  bool isLoading = false;

  Future<void> attemptLogin(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final String username = windController.text;
    final String password = tempController.text;

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
          title: Text('Nueva Alerta'),
          actions: [
            
          ],
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new PageHeader(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: windController,
                decoration: InputDecoration(
                  labelText: 'Velocidad del viento >',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: tempController,
                decoration: InputDecoration(
                  labelText: 'Temperatura <',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para verificar las credenciales
                
              },
              child: Text('Crear'),
            ),
            
          ],
        ),
      ),
      );
  
  }
}
