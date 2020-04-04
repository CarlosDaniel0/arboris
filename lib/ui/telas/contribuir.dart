import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contribuir extends StatefulWidget {
  @override
  _ContribuirState createState() => _ContribuirState();
}

class _ContribuirState extends State<Contribuir> {

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
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contribuir"),
      ),

      body: questionario()
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
  _pegarLocalizacaoAtual();

  return StreamBuilder(
    stream: Firestore.instance.collection('dados').snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text("Erro: ${snapshot.error}"));
    } 
    if (!snapshot.hasData) {
      return Center(
        child:  CircularProgressIndicator(
          value: snapshot.data != null ? 
          snapshot.data.cumulativeBytesLoaded / snapshot.data.expectedTotalBytes : 
          null,
        ));

    }
    int id;
    List<DocumentSnapshot> document = snapshot.data.documents;
    for (int i = 0; i < document.length; i++) {
      if (document[i]['idArvore'] == document.length) {
        id = document[i]['idArvore'] + 1;
      }
    }

    Widget widget;
    if (local != null) {
      widget = ListView(
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
                    title: Text("Clique no icone abaixo para verificar sua localização", style: titulo()),
                  ),
              ),

              Container(
                height: 200,
                child: Mapa(
                  localizacao: local
                )
              ),
              
              // Row(
              //   children: <Widget>[
              //     Text("Não é a localização correta?", style: titulo()),
              //     FlatButton(
              //         color: Colors.green,
              //         child: Text("Definir no mapa", style: TextStyle(color: Colors.white)),
              //         onPressed: () {
              //           Navigator.push(
              //             context, MaterialPageRoute(builder: (context) => DefinirLocal(
              //             ))
              //           );
              //         },
              //       ),
              //   ],
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Colors.green,
                  child: Text("Enviar", style: TextStyle(color: Colors.white)),
                  onPressed:  () {
                    setState(() {
                      if (nome.text != "null" && arvore.text != "" && categoria.text != "" && descricao.text != "") {
                        mostrarMensagem(context, "Uma página será aberta em seu navegador para concluir o cadastro", "", Icon(Icons.info, color: Colors.blue,));
                        launch("https://docs.google.com/forms/d/e/1FAIpQLSc5IjrxtAYmvjpbl8bcHhWavGv0W3_gtWP1xI-Qclg4ze1icg/viewform?usp=pp_url&entry.1856495010=$id&entry.1394939468=${nome.text}&entry.886931031=${arvore.text}&entry.632164459=${descricao.text}&entry.712798933=${categoria.text}&entry.1936786832=${local.latitude}&entry.1786512522=${local.longitude}");
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
      );
    }
    else if (local == null) {
        widget = Card(
          child: ListTile(
            title: Icon(Icons.warning, color: Colors.red),
            subtitle: Text("Para colaborar com o projeto é essencial a permissão de localização do seu dispositivo.", style: texto(),),
          ),
        );
    }

    return widget;
      
    },
  );
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
    @required this.localizacao,
  }) : super(key:key);


  final LatLng localizacao;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (control) {
      },
      initialCameraPosition: CameraPosition(
        target: localizacao,
        zoom: 15.5
      ),
      myLocationEnabled: true,
    );
  }
}