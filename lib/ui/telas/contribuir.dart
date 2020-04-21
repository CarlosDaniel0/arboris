import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'definirlocal.dart';

class Contribuir extends StatefulWidget {
  Contribuir({Key key, this.id, this.error}) : super(key:key);
  final int id;
  final String error;
  @override
  _ContribuirState createState() => _ContribuirState(id: id, error: error);
}

MapController mapController;
class _ContribuirState extends State<Contribuir> {
  _ContribuirState({this.id, this.error});
  final String error;
  final int id;
  LatLng definirLocal;
  LatLng local;
  TextEditingController nome = TextEditingController();
  TextEditingController arvore = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController categoria = TextEditingController();
                                                                                                                                                                                                                                   
  void _pegarLocalizacaoAtual() async {
    final posicao = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
       local = LatLng(posicao.latitude, posicao.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _pegarLocalizacaoAtual();
    mapController = MapController();
  }
  String ativo;
  @override
  Widget build(BuildContext context) {  
    return Stack(
      children: <Widget>[
        questionario(),
        if (error != null)
        ativo == null ? GestureDetector(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: ListTile(
                  title: Icon(Icons.warning, color: Colors.yellow),
                  subtitle: Text("Sem internet! \nVerifique sua conexão ou tente mais tarde."),
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              ativo = "nao";
            });
          },
        ) : Container()
      ],
    );    
  }

  TextStyle titulo() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  TextStyle texto() {
    return TextStyle(
      fontSize: 18
    );
  }

  Widget questionario() {
  return 
  local != null ?    
  ListView(
    children: <Widget>[
      TextField(
        controller: nome,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.blue),
          hintText: "Seu nome",
          labelText: 'Nome'),
      ),
      TextField(
        controller: arvore,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: FaIcon(FontAwesomeIcons.tree, color: Colors.green),
          ),
          hintText: "Nome da árvore",
          labelText: 'Árvore'),
      ),

      TextField(
        controller: descricao,
        decoration: InputDecoration(
          icon: Icon(Icons.assignment, color: Colors.blue,),
          hintText: "Uma breve descrição da árvore.",
          labelText: 'Descrição'),
      ),
      TextField(
        controller: categoria,
        decoration: InputDecoration(
          icon: Icon(Icons.bookmark, color: Colors.blue,),
          hintText: "Futífera, Ornamental ou Geral",
          labelText: 'Categoria'),
      ),

      Card(
        child: ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text("Verifique sua localização antes de enviar sua sugestão", style: titulo()),
          ),
      ),

      Container(
        height: 200,
        child: Mapa(posicao: local, defLocal: definirLocal)
        ),    

      GestureDetector(
        onTap: () {
          _navegarEReceberValor(context, local);
        },
        child: Card(
          child: ListTile(
            leading: Icon(Icons.location_on, color: Colors.red),
            title: Text("Não é a localização correta? \nClique para definir no mapa", style: titulo()),
            trailing: Icon(Icons.arrow_forward, color: Colors.blue),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: RaisedButton(
          color: Colors.green,
          child: Text("Enviar", style: TextStyle(color: Colors.white)),
          onPressed:  () {
            setState(() {
              if (nome.text != "null" && arvore.text != "" && categoria.text != "" && descricao.text != "") {
                mostrarMensagem(context, "Uma página será aberta em seu navegador para concluir o cadastro", "", Icon(Icons.info, color: Colors.blue,));
                launch("https://docs.google.com/forms/d/e/1FAIpQLSc5IjrxtAYmvjpbl8bcHhWavGv0W3_gtWP1xI-Qclg4ze1icg/viewform?usp=pp_url&entry.1856495010=$id&entry.1394939468=${nome.text}&entry.886931031=${arvore.text}&entry.632164459=${descricao.text}&entry.712798933=${categoria.text}&entry.1936786832=${definirLocal != null ? definirLocal.latitude : local.latitude}&entry.1786512522=${definirLocal != null ? definirLocal.longitude : local.longitude}");
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) => Navegador(
                //     url: "https://docs.google.com/forms/d/e/1FAIpQLSc5IjrxtAYmvjpbl8bcHhWavGv0W3_gtWP1xI-Qclg4ze1icg/viewform?usp=pp_url&entry.1856495010=$id&entry.1394939468=${nome.text}&entry.886931031=${arvore.text}&entry.632164459=${descricao.text}&entry.712798933=${categoria.text}&entry.1936786832=${definirLocal != null ? definirLocal.latitude : local.latitude}&entry.1786512522=${definirLocal != null ? definirLocal.longitude : local.longitude}"
                //     )
                //   )
                // );
                nome.clear();
                arvore.clear();
                categoria.clear();
                descricao.clear();
              } else {
                mostrarMensagem(context, "Preencha todos os campos antes de enviar as informações!", "Atenção", Icon(Icons.warning, color: Colors.red,));
              }
            });
          },
        ),
      ),
    ],
  ) : Card(
      child: ListTile(
        title: Icon(Icons.warning, color: Colors.red),
        subtitle: Text("Para colaborar com o projeto é essencial a permissão de localização do seu dispositivo.", style: texto(),),
      ),
    );
  } 
  _navegarEReceberValor(BuildContext context, LatLng local) async {
    final resultado = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => DefinirLocal(
        local: local,
      ))
    );

    setState(() {
      definirLocal = resultado;
      if (resultado != null) {
        mapController.move(definirLocal, 18);
      }
    });
  }
}

  

void mostrarMensagem(BuildContext context, String mensagem, String titulo, Icon icon) {
  var alert = new AlertDialog(
    title: Text("$titulo"),
    content: Column(
      children: <Widget>[
        icon,
        Text("$mensagem")
    ],),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "OK"
        ),
      )
    ],
  );

  showDialog(context: context, builder: (_){
      return alert;
    }
  );
}

class Mapa extends StatelessWidget {
  Mapa({
    Key key,
    @required this.posicao,
    @required this.defLocal,
  }) : super(key: key);

  final LatLng posicao;
  final LatLng defLocal;
  
  @override
  Widget build(BuildContext context) {
    return 
      FlutterMap(
          mapController: mapController,
        options: MapOptions(
          center: posicao,
          zoom: 17.0,
          maxZoom: 18.0,
          onTap: (latlng) {
          }
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://api.mapbox.com/styles/v1/carlosdaniel0/ck90ounvk0ff91iphmo4px8k7/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2FybG9zZGFuaWVsMCIsImEiOiJjazcyMjV4MTMwYnMxM2ZtaHZ3NHd0cDAyIn0.BupifLM_8QmbxYvJEWM7-w',
            additionalOptions: {
              'accessToken' : 'pk.eyJ1IjoiY2FybG9zZGFuaWVsMCIsImEiOiJjazcyMjV4MTMwYnMxM2ZtaHZ3NHd0cDAyIn0.BupifLM_8QmbxYvJEWM7-w',
              'id' : 'mapbox.mapbox-streets-v8'
            },
          ),
          MarkerLayerOptions(
            markers: [
                Marker(
                width: 45.0,
                height: 45.0,
                anchorPos: defLocal != null ? AnchorPos.align(AnchorAlign.top) : AnchorPos.align(AnchorAlign.center),
                point: defLocal != null ? defLocal : posicao,
                builder: (context) => Container(
                  child:
                    IconButton(
                          icon: 
                          defLocal != null ? Icon(Icons.location_on, color: Colors.red) : Icon(Icons.my_location, color: Colors.blue,),
                          // FaIcon(FontAwesomeIcons.tree, color: Colors.green), 
                          onPressed: () {
                          }),
                    ),
                  )
                ]
              ),
            ]
      );
  }
}

// -5.56701 | -42.611225 or 5.56701 | -42.611225