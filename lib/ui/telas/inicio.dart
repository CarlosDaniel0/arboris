import 'package:arboris/ui/descricao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Inicio extends StatefulWidget {
  Inicio({
    Key key,
    this.dados,
    this.error
  }):super(key:key);
  final List dados;
  final String error;
  _InicioState createState() => _InicioState(dados: dados, error: error);
}

String ativo;
String titulo = "";
String informacao = "";
String categoria = "Todas";
int id;
List<Marker> marcadores;

class _InicioState extends State<Inicio> {
  _InicioState({
    this.dados,
    this.error
  });
  final List dados;
  final String error;
  @override
  Widget build(BuildContext context) {
    return 
        Stack(
          children: <Widget>
          [FlutterMap(
            options: MapOptions(
              center: LatLng(-5.565041, -42.608059),
              zoom: 15.0,
              maxZoom: 18.3,
              onTap: (latlng) {
                setState(() {
                  titulo = "";
                  informacao = "";
                });
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
              if (error == null) 
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < dados.length; i++)
                    if (categoria == "Todas")
                      Marker(
                      width: 65.0,
                      height: 65.0,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      point: LatLng(dados[i]['localizacao'][0], dados[i]['localizacao'][1]),
                      builder: (context) => Container(
                        child:
                          GestureDetector(
                            onLongPress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                Descricao(
                                  titulo: dados[i]['titulo'], 
                                  descricao: dados[i]['descricao'], 
                                  categoria: dados[i]['categoria'], 
                                  height: dados[i]['height'], 
                                  fotos: dados[i]['fotos'], 
                                  fotografos: dados[i]['fotografos'])
                                ));
                            },
                            child: IconButton(
                              iconSize: 55,
                              icon: 
                              Image.asset("assets/icon.png"),
                              // Icon(Icons.location_on),
                              // FaIcon(FontAwesomeIcons.tree, color: Colors.green), 
                              onPressed: () {
                                setState(() {
                                  id = i;
                                  titulo = dados[i]['titulo'];
                                  informacao = dados[i]['descricao'];
                                });
                              }
                            )
                          )
                        )
                      )
                      else if (categoria == dados[i]["categoria"])
                        Marker(
                      width: 65.0,
                      height: 65.0,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      point: LatLng(dados[i]['localizacao'][0], dados[i]['localizacao'][1]),
                      builder: (context) => Container(
                        child:
                          GestureDetector(
                            onLongPress: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                Descricao(
                                  titulo: dados[i]['titulo'], 
                                  descricao: dados[i]['descricao'], 
                                  categoria: dados[i]['categoria'], 
                                  height: dados[i]['height'], 
                                  fotos: dados[i]['fotos'], 
                                  fotografos: dados[i]['fotografos'])
                                ));
                            },
                            child: IconButton(
                              iconSize: 55,
                              icon: 
                              Image.asset("assets/icon.png"),
                              // FaIcon(FontAwesomeIcons.tree, color: Colors.green), 
                              onPressed: () {
                                setState(() {
                                  id = i;
                                  titulo = dados[i]['titulo'];
                                  informacao = dados[i]['descricao'];
                                });
                              }
                            )
                          )
                        )
                      )
                    ]
                  )
                ],
              ), 
                // Menu de categorias.
             Align(
               alignment: Alignment.topLeft,
               child: Container(
                 margin: const EdgeInsets.symmetric(vertical: 10),
                 height: 35,
                 child: ListView(
                   scrollDirection: Axis.horizontal,
                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                   children: <Widget>[
                     // Botões de ação
                     Container(
                       child: FlatButton(child: Text("Todas"), onPressed: () {
                         setState(() {
                           categoria = "Todas";
                         });
                       }),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(Radius.circular(45))
                       ),
                     ),

                     Padding(
                       padding: const EdgeInsets.only(right: 5.0),
                     ),
  
                     Container(
                       child: FlatButton(child: Text("Frutífera"), onPressed: () {
                         setState(() {
                           categoria = "Frutífera";
                         });
                       },),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(45))
                       ),
                     ),
  
                     Padding(
                       padding: const EdgeInsets.only(right: 5.0),
                     ),
  
                     Container(
                       child: FlatButton(child: Text("Ornamental"), onPressed: () {
                         setState(() {
                           categoria = "Ornamental";
                         });
                       }),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(Radius.circular(45))
                       ),
                     ),
  
                     Padding(
                       padding: const EdgeInsets.only(right: 5.0),
                     ),
  
                     Container(
                       child: FlatButton(child: Text("Geral"), onPressed: () {
                         setState(() {
                           categoria = "Geral";
                         });
                       }),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(Radius.circular(45))
                       ),
                     ),
  
                     Padding(
                       padding: const EdgeInsets.only(right: 5.0),
                     ),
                   ],
                 ),
               ),
             ),
            
            // Mensagem de erro
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
             ) : Container(),
             
            titulo != "" ? Info(id: id, dados: dados, titulo: titulo, informacao: informacao) : Container()
          ] 
        );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key key,
    @required this.id,
    @required this.dados,
    @required this.titulo,
    @required this.informacao,
  }) : super(key:key);

  final String titulo;
  final String informacao;
  final List dados;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                Descricao(
                  titulo: dados[id]['titulo'], 
                  descricao: dados[id]['descricao'], 
                  categoria: dados[id]['categoria'], 
                  height: dados[id]['height'], 
                  fotos: dados[id]['fotos'], 
                  fotografos: dados[id]['fotografos'])
                ));
            },
            child: ListTile( 
              // CircleAvatar(child: Image.asset("assets/icon.png")),
              // FaIcon(FontAwesomeIcons.tree, color: Colors.green),
              title: Text(titulo, style: styleTitulo(),),
              subtitle: Text(informacao, style: styleSubtitulo(),),
              trailing: Icon(Icons.arrow_forward, color: Colors.blue),
              
            ),
          ),
        ),
      ),
    );
  }

    TextStyle styleTitulo() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  TextStyle styleSubtitulo() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.black
    );
  }
}