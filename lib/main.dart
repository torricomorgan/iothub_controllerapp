import 'package:flutter/material.dart';
import 'dart:async';
import 'package:iothub_controller/controladorPage.dart';
import 'package:iothub_controller/sensoresPage.dart';
import 'package:iothub_controller/reportesPage.dart';

void main()=>runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
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
  final List<Widget> paginas = [
    sensores(),
    controladorPage(),
    reportesPage()
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _indexActual,
         type: BottomNavigationBarType.shifting,
         items: [
           BottomNavigationBarItem(
             icon: Icon(Icons.waves),
             label: 'Sensores',
             backgroundColor: Colors.indigo
             ),
           BottomNavigationBarItem(
             icon: Icon(Icons.settings_applications),
             label: 'Actuadores',
             backgroundColor: Colors.lightGreen
             ),
           BottomNavigationBarItem(
             icon: Icon(Icons.grading_sharp),
             label: 'Reporte',
             backgroundColor: Colors.amber
             )
         ],
         onTap: (index){
           setState(() {
             _indexActual=index;
           });
         },
       ),
       body: paginas[_indexActual],
      ),
    );
  }
}
