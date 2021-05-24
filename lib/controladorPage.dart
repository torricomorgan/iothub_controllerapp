import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class controladorPage extends StatefulWidget {
  controladorPage({Key key}) : super(key: key);

  @override
  _controladorPageState createState() => _controladorPageState();
}

class _controladorPageState extends State<controladorPage> {
  int numero=0;

  Future<String> sendData(String nd, String m) async{
    var response = await http.post(
      Uri.encodeFull("https://apisenddevice.azurewebsites.net/api/data"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(<String, dynamic>{
        "NameDevice":nd,
        "Mensaje":m})
      );
      print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: const Text('Controles'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text ('Bomba de Agua'),
              new Image.network('https://i2.wp.com/www.ecrobotics.com.bo/wp-content/uploads/2019/07/72369a74-59a4-4377-8180-0f4d3e3b7292.jpg',
              height: 200,
              width: 200),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                new TextButton(
                  style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(150,25),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){
                  sendData("ESP-02","on");
                  showDialog(context: context,
                  barrierDismissible: false, 
                  builder: (context)=> AlertDialog(
                    title: Text('Confirmación'),
                    content: Text('Accion registrada, espere 5 seg. por favor'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: (){
                        Future.delayed(Duration(milliseconds: 3000), () {
                          Navigator.of(context).pop('Ok');
                         }); 
                        },
                      ),
                    ],
                  )
                  );
                },
                child: new Text("Encender")
              ),
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(150,25),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){
                  sendData("ESP-02","off");
                  showDialog(context: context, 
                  barrierDismissible: false,
                  builder: (context)=> AlertDialog(
                    title: Text('Confirmación'),
                    content: Text('Accion registrada, espere 5 seg. por favor'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: (){
                        Future.delayed(Duration(milliseconds: 3000), () {
                          Navigator.of(context).pop('Ok');
                         }); 
                        },
                      ),
                    ],
                  )
                  );
                },
                child: new Text("Apagar")
              ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 0,
                color: Colors.white,
              ),
              new Text ('Cinta Transportadora (Servo)'),
              new Image.network('https://www.aranacorp.com/wp-content/uploads/towerpro-servo-sg90.jpg',
              height: 200,
              width: 200),
              new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(150,25),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){
                  sendData("ESP-01","on");
                  showDialog(context: context, 
                  barrierDismissible: false,
                  builder: (context)=> AlertDialog(
                    title: Text('Confirmación'),
                    content: Text('Accion registrada, espere 5 seg. por favor'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: (){
                        Future.delayed(Duration(milliseconds: 3000), () {
                          Navigator.of(context).pop('Ok');
                         }); 
                        },
                      ),
                    ],
                  )
                  );
                },
                child: new Text("Encender")
              ),
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(150,25),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){
                  sendData("ESP-01","off");
                  showDialog(context: context, 
                  barrierDismissible: false,
                  builder: (context)=> AlertDialog(
                    title: Text('Confirmación'),
                    content: Text('Accion registrada, espere 5 seg. por favor'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: (){
                        Future.delayed(Duration(milliseconds: 3000), () {
                          Navigator.of(context).pop('Ok');
                         }); 
                        },
                      ),
                    ],
                  )
                  );
                },
                child: new Text("Apagar")
              ),]
              ),

            ],
          ),
        ),
      ),
    );
  }
}