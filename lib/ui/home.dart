import 'package:arboris/ui/telas/inicio.dart';
import 'package:flutter/material.dart';
import './telas/sobre.dart';
import './telas/contribuir.dart';
import './telas/sobre_o_app.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    this.dados,
    this.error
  }):super(key:key);
  final List dados;
  final String error;
  _HomeState createState() => _HomeState(dados: dados, error: error);
}

String ativo;
String tituloApp = "Arbóris";
int id;
List<Marker> marcadores;

class _HomeState extends State<Home> {
  _HomeState({
    this.dados,
    this.error
  });
  final List dados;
  final String error;
  int _indicieSelecao = 0;
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.init("3a00daef-f90f-437e-84a2-caedc9082ef7");
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    // OneSignal.shared.setNotificationReceivedHandler((oSNotification) {

    // });
    return Scaffold(
        appBar: AppBar(
          title: Text("$tituloApp"),
          centerTitle: true,
        ),
        
        // Menu lateral esquerdo com opções extas
        drawer: Drawer(
          child: Padding(
            padding:  const EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                FlatButton(
                  
                  onPressed: () {
                    _selecionarItem(0, "Arbóris");
                  },
                  child: ListTile(
                    selected: 0 == _indicieSelecao,
                    title: Text("Início"),
                    leading: Icon(Icons.home, color: 0 == _indicieSelecao ? Colors.green : Colors.blue),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _selecionarItem(1, "Sobre Nós");
                  },
                  child: ListTile(
                    selected: 1 == _indicieSelecao,
                    title: Text("Sobre Nós"),
                    leading: Icon(Icons.people, color: 1 == _indicieSelecao ? Colors.green : Colors.blue),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    _selecionarItem(2, "Sobre o App");
                  },
                  child: ListTile(
                    selected: 2 == _indicieSelecao,
                    title: Text("Sobre o App"),
                    leading: Icon(Icons.info_outline, color: 2 == _indicieSelecao ? Colors.green : Colors.blue),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    _selecionarItem(3, "Contribuir");
                  },
                  child: ListTile(
                    selected: 3 == _indicieSelecao,
                    title: Text("Contribuir"),
                    leading: Icon(Icons.add, color: 3 == _indicieSelecao ? Colors.green : Colors.blue),
                  ),
                )           
              ],
            ),
          )
        ),
        body: 
          _mostrarItem(_indicieSelecao)
      );
  }

  _selecionarItem(int index, String titulo) {
    setState(() {
      _indicieSelecao = index;
      tituloApp = titulo;
      });
    Navigator.pop(context);
  }

  _mostrarItem(int pos) {
    switch(pos) {
      case 0:
        return Inicio(dados: dados, error: error,);
      case 1:
        return Sobre();
      case 2:
        return SobreOApp();
      case 3:
        return Contribuir(id: dados != null ? dados.length + 1 : 0, error: error);
    }
  }
}
