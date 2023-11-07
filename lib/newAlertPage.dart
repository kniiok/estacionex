import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sensor_flutter_app/page_header.dart';
import 'package:sensor_flutter_app/stationDetailPage.dart';
import 'package:sensor_flutter_app/stationListPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class NewAlertPage extends StatefulWidget {
  const NewAlertPage(this.stationName, {super.key});
  final String stationName;
  @override
  _NewAlertPageState createState() => _NewAlertPageState();
}

class _NewAlertPageState extends State<NewAlertPage> {
  final apiUrl = Uri.parse("http://150.230.80.1:18083/api/v5/rules");
  final TextEditingController windController = TextEditingController();
  final TextEditingController tempController = TextEditingController();

  bool isLoading = false;

  Future<void> sendPostRequest(stationName) async {
    final username = '0864e2a5beed02b6';
    final password = 'QHiMVaBAiortnOrw33hk0hHxLqlAwlt1zzb6hud0USJ';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    
    var temp=tempController.text;
    var wind=windController.text;
    var response = await http.post(apiUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth
        },
        body: jsonEncode({
          "name": "Rule-$stationName-t:$temp-w:$wind",
          "sql":
              "SELECT * FROM \"$stationName\" WHERE payload.data.temp < $temp AND payload.data.wind_speed_hi_last_2_min > $wind",
          "actions": [
            "webhook:alarm",
            {
              
              "args": {
                "payload":
                    "{\${payload.data.temp}, \${payload.data.wind_speed_hi_last_2_min}}",
                "topic": "Alertas",
                "qos" : 2,
                "retain" : "true"
               },
              "function": "republish",
             
            },
            
          ],
          "enable": true,
          "description": "Some description",
          "metadata": {}
        }));
    //print(response.statusCode);
    if (response.statusCode == 201) {
     showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alerta Creada Exitosamente!'),
          content: Text('Estación: $stationName \nViento > $wind \nTemperatura < $temp'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      windController.text='';
      tempController.text='';
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No se pudo crear la Alerta!'),
          content: const Text('Intentelo nuevamente'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Alerta'),
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new PageHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: windController,
                decoration: const InputDecoration(
                  labelText: 'Velocidad del viento >',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: tempController,
                decoration: const InputDecoration(
                  labelText: 'Temperatura <',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para verificar las credenciales
                //print(widget.stationName);
                sendPostRequest(widget.stationName);
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}

