import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:math';

class sensores extends StatefulWidget {
  sensores({Key key}) : super(key: key);

  @override
  _sensoresState createState() => _sensoresState();
}

int numero=0;

class _sensoresState extends State<sensores> {

Future<String> sendData() async{
    Random va = new Random();
    int aleatorio = va.nextInt(1001); //De 0 a incluyendo 1000
    numero=aleatorio;
    print(aleatorio);
    DateTime fechahora = DateTime.now();
    String fechaformato = DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechahora);
    var response = await http.post(
      Uri.encodeFull("https://apidoblematias.azurewebsites.net/api/aleatorio"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(<String, dynamic>{
        "DateTime":fechaformato,
        "ValorRandom":aleatorio})
      );
      print(response.body);
    return response.body;
  }

 
  Future getdata() async{
    var response = await http.get(
    Uri.https('fncgettelemetria.azurewebsites.net', 'api/telemetria'));
    var jsonDatos = jsonDecode(response.body);
    List<Datos> datos = [];
    for(var u in jsonDatos){
      Datos data = Datos(u['NameDevice'],u['Temperatura'],u['Humedad'],u['EventDateTime']);
       datos.add(data);
    }
    return datos;
  }

  recargar(){
    setState(() {
    });
  }

  Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
       counter++; 
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int _indexActual = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[100],
          title: const Text('IoTHub - Telemetria'),
        ),
       body: Container(
         child: Card(child: FutureBuilder(
           future: getdata(),
           builder: (context, snapshot){
             if(snapshot.data==null){
               return Container(
                 child: Center(child: Text('Cargando...'),
                 ),
               );
             }else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  return ListTile(
                    title: Text(snapshot.data[i].NameDevice),
                    subtitle: Text('Temperatura: ' + snapshot.data[i].Temperatura+'°C'+' Humedad: ' + snapshot.data[i].Humedad+'%'),
                    trailing: Text(snapshot.data[i].EventDateTime),
                  );
                }
                );
           },
         ),
         ),
       ), 
      ),
    );
  }
}

class Datos {
  final String NameDevice, Temperatura, Humedad, EventDateTime;
  Datos(this.NameDevice, this.Temperatura, this.Humedad, this.EventDateTime);
}