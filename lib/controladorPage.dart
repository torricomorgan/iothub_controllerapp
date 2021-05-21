import 'package:flutter/material.dart';

class controladorPage extends StatefulWidget {
  controladorPage({Key key}) : super(key: key);

  @override
  _controladorPageState createState() => _controladorPageState();
}

class _controladorPageState extends State<controladorPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[200],
          title: const Text('Controles'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.network('https://i2.wp.com/www.ecrobotics.com.bo/wp-content/uploads/2019/07/72369a74-59a4-4377-8180-0f4d3e3b7292.jpg',
              height: 200,
              width: 200),
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigo[200],
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(250,50),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){

                },
                child: new Text("Encender/Apagar")
              ),
              Divider(
                height: 50,
                thickness: 0,
                color: Colors.white,
              ),
              new Image.network('https://www.aranacorp.com/wp-content/uploads/towerpro-servo-sg90.jpg',
              height: 200,
              width: 200),
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigo[200],
                  primary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size(250,50),   	
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ), 
                ),
                onPressed: (){

                },
                child: new Text("Encender/Apagar")
              ),
            ],
          ),
        ),
      ),
    );
  }
}