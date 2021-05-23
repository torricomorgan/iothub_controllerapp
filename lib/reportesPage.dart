import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://app.powerbi.com/links/cE2sLYCTX3?ctid=5de44bb7-d2e6-4877-bb05-7b13327bd039&pbi_source=linkShare';

class reportesPage extends StatefulWidget {
  reportesPage({Key key}) : super(key: key);

  @override
  _reportesPageState createState() => _reportesPageState();
}

class _reportesPageState extends State<reportesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[100],
          title: const Text('Reporte PowerBi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Power_bi_logo_black.svg/1200px-Power_bi_logo_black.svg.png',
              height: 350,
              width: 300),
              Divider(
                height: 50,
                thickness: 0,
                color: Colors.white,
              ),
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
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
                  _launchURL(); 
                },
                child: new Text("Ver Informe")
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}