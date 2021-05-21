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
    Uri.https('fncgetdatos-tecnoupsa.azurewebsites.net', 'api/telemetria01'));
    var jsonDatos = jsonDecode(response.body);
    List<Datos> datos = [];
    for(var u in jsonDatos){
      Datos data = Datos(u['NameDevice'],u['Temperatura'],u['Humedad'],u['EventDateTime'],u['MicroServo'].toString(),u['Buzzer'].toString());
       datos.add(data);
    }
    return datos;
  }

    Future getdata2() async{
    var response = await http.get(
    Uri.https('fncgetdatos-tecnoupsa.azurewebsites.net', 'api/telemetria02'));
    var jsonDatos = jsonDecode(response.body);
    List<Datos2> datos = [];
    for(var u in jsonDatos){
      Datos2 data = Datos2(u['NameDevice'],u['Temperatura'],u['Humedad'],u['EventDateTime'],u['BombaAgua'].toString(),u['Buzzer'].toString());
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

  @override
  Widget build(BuildContext context) {

return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[100],
          title: const Text('IoTHub - Telemetria'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
           Card(child: FutureBuilder(
           future: getdata(),
           builder: (context, snapshot){
             if(snapshot.data==null){
               return Container(
                 child: Center(child: Text('Cargando...'),
                 ),
               );
             }else
              return ListView.builder(
                shrinkWrap: true,
                itemExtent: 100,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  return ListTile(
                    title: Text(snapshot.data[i].NameDevice),
                    subtitle: Text('Temperatura: ' + snapshot.data[i].Temperatura+'°C'
                    +' Humedad: ' + snapshot.data[i].Humedad+'%'
                    + "        Estado MicroServo: " + snapshot.data[i].MicroServo
                    + "      Estado Buzzer: " + snapshot.data[i].Buzzer),
                    trailing: Text(snapshot.data[i].EventDateTime),
                  );
                }
                );
           },
         ),
         ),
         Card(child: FutureBuilder(
           future: getdata2(),
           builder: (context, snapshot){
             if(snapshot.data==null){
               return Container(
                 child: Center(child: Text('Cargando...'),
                 ),
               );
             }else
              return ListView.builder(
                shrinkWrap: true,
                itemExtent: 100,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  return ListTile(
                    title: Text(snapshot.data[i].NameDevice2),
                    subtitle: Text('Temperatura: ' + snapshot.data[i].Temperatura2+'°C'
                    +' Humedad: ' + snapshot.data[i].Humedad2+'%'
                    + "        Estado Bomba Agua: " + snapshot.data[i].BombaAgua
                    + "      Estado Buzzer: " + snapshot.data[i].Buzzer2),
                    trailing: Text(snapshot.data[i].EventDateTime2),
                  );
                }
                );
           },
         ),
         ),
            ],
          ),
        ),
      ),
    );
  }
}

class Datos {
  final String NameDevice, Temperatura, Humedad, EventDateTime, MicroServo, Buzzer;
  Datos(this.NameDevice, this.Temperatura, this.Humedad, this.EventDateTime, this.MicroServo, this.Buzzer);
}

class Datos2 {
  final String NameDevice2, Temperatura2, Humedad2, EventDateTime2, BombaAgua, Buzzer2;
  Datos2(this.NameDevice2, this.Temperatura2, this.Humedad2, this.EventDateTime2, this.BombaAgua, this.Buzzer2);
}