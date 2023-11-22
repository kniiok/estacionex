
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
  final TextEditingController windMaxController = TextEditingController();
  final TextEditingController windMinController = TextEditingController();
  final TextEditingController tempMaxController = TextEditingController();
  final TextEditingController tempMinController = TextEditingController();
  final TextEditingController humMaxController = TextEditingController();
  final TextEditingController humMinController = TextEditingController();
  final TextEditingController dewMaxController = TextEditingController();
  final TextEditingController dewMinController = TextEditingController();

  bool isLoading = false;

  Future<void> sendPostRequest(stationName) async {
    final username = '0864e2a5beed02b6';
    final password = 'QHiMVaBAiortnOrw33hk0hHxLqlAwlt1zzb6hud0USJ';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    
    var query = "SELECT * FROM \"$stationName\" WHERE";
    String payload = '{"topic": "$stationName", "data": {';

    if(windMaxController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.wind_speed_hi_last_2_min <= "+(int.parse(windMaxController.text)/1.60934).toString(); 
      }else{
      query += " AND payload.data.wind_speed_hi_last_2_min <= "+(int.parse(windMaxController.text)/1.60934).toString();  
      }
      
    }
    if(windMinController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.wind_speed_hi_last_2_min >= "+(int.parse(windMinController.text)/1.60934).toString(); 
      }else{
      query += " AND payload.data.wind_speed_hi_last_2_min >= "+(int.parse(windMinController.text)/1.60934).toString();  
      }
    }
    if(windMaxController.text.isNotEmpty || windMinController.text.isNotEmpty){
      payload += '"wind_speed_hi_last_2_min": \${payload.data.wind_speed_hi_last_2_min}, ';
    }
    if(tempMaxController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.temp <= "+((int.parse(tempMaxController.text)*(9/5))+32).toString(); 
      }else{
      query += " AND payload.data.temp <= "+((int.parse(tempMaxController.text)*(9/5))+32).toString();  
      }
    }
    if(tempMinController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.temp >= "+((int.parse(tempMinController.text)*(9/5))+32).toString(); 
      }else{
      query += " AND payload.data.temp >= "+((int.parse(tempMinController.text)*(9/5))+32).toString();  
      }
    }
     if(tempMaxController.text.isNotEmpty || tempMinController.text.isNotEmpty){
      payload += '"temp": \${payload.data.temp}, ';
    }
    if(humMaxController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.hum <= "+humMaxController.text; 
      }else{
      query += " AND payload.hum <= "+humMaxController.text;  
      }
    }
    if(humMinController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.hum >= "+humMinController.text; 
      }else{
      query += " AND payload.data.hum >= "+humMinController.text;  
      }
    }
     if(humMaxController.text.isNotEmpty || humMinController.text.isNotEmpty){
      payload += '"hum": \${payload.data.hum}, ';
    }
    if(dewMaxController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.dew_point <= "+((int.parse(dewMaxController.text)*(9/5))+32).toString(); 
      }else{
      query += " AND payload.data.dew_point <= "+((int.parse(dewMaxController.text)*(9/5))+32).toString();  
      }
    }
    if(dewMinController.text.isNotEmpty){
      if(query[query.length-1]=='E'){
      query += " payload.data.dew_point >= "+((int.parse(dewMinController.text)*(9/5))+32).toString(); 
      }else{
      query += " AND payload.data.dew_point >= "+((int.parse(dewMinController.text)*(9/5))+32).toString();  
      }
    }
     if(dewMaxController.text.isNotEmpty || dewMinController.text.isNotEmpty){
      payload += '"dew_point": \${payload.data.dew_point}, ';
    }
    payload = payload.substring(0, payload.length - 2);
    payload += '}}';
    var response = await http.post(apiUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth
        },
        body: jsonEncode({
          "name": "Rule-$stationName-Alarm",
          "sql":
              query,
          "actions": [
            "webhook:alarm",
            {
              "args": {
                "payload":
                    payload,
                "topic": "Alertas",
                "qos": 2,
                "retain": "false"
              },
              "function": "republish",
            },
          ],
          "enable": true,
          "description": "Some description",
          "metadata": {}
        }));
    
    if (response.statusCode == 201) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alerta Creada Exitosamente!'),
          content: Text(
              'Estación: $stationName'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      windMaxController.text = '';
      tempMaxController.text = '';
      humMaxController.text = '';
      dewMaxController.text = '';
      windMinController.text = '';
      tempMinController.text = '';
      humMinController.text = '';
      dewMinController.text = '';
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No se pudo crear la Alerta! Intentelo nuevamente'),
          content: const Text('Ingrese los datos'),
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
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new PageHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: windMaxController,
                decoration: const InputDecoration(
                  labelText: 'Velocidad del viento Max',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: windMinController,
                decoration: const InputDecoration(
                  labelText: 'Velocidad del viento Min',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: tempMaxController,
                decoration: const InputDecoration(
                  labelText: 'Temperatura Max',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: tempMinController,
                decoration: const InputDecoration(
                  labelText: 'Temperatura Min',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: humMaxController,
                decoration: const InputDecoration(
                  labelText: 'Humedad Max',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: humMinController,
                decoration: const InputDecoration(
                  labelText: 'Humedad Min',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: dewMaxController,
                decoration: const InputDecoration(
                  labelText: 'Punto de Rocío Max',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: dewMinController,
                decoration: const InputDecoration(
                  labelText: 'Punto de Rocío Min',
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
      )),
    );
  }
}
