import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './telas/sobre.dart';
import './telas/contribuir.dart';
import './telas/sobre_o_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'descricao.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Stream<QuerySnapshot> _arvoresArmazenadas;
  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/icon.png').then((onValue) {
      pinLocationIcon = onValue;
    });

    _arvoresArmazenadas = Firestore.instance
      .collection("dados")
      .orderBy("titulo")
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Arbóris"),
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
                    Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => Sobre())
                      );
                  },
                  child: ListTile(
                    title: Text("Sobre Nós"),
                    leading: Icon(Icons.people, color: Colors.blue),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => SobreOApp())
                      );
                  },
                  child: ListTile(
                    title: Text("Sobre o App"),
                    leading: Icon(Icons.info_outline, color: Colors.blue),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => Contribuir())
                      );
                  },
                  child: ListTile(
                    title: Text("Contribuir"),
                    leading: Icon(Icons.add, color: Colors.blue),
                  ),
                )           
              ],
            ),
          )
        ),

        body: 
        
        StreamBuilder(
          stream: _arvoresArmazenadas,
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

            return MapaArmazenado(
                  documents: snapshot.data.documents,
                  initialPosition: const LatLng(-5.565041, -42.608059),
                  pinLocationIcon: pinLocationIcon,
                );
          })
      );
  }
}

class MapaArmazenado extends StatelessWidget {
  const MapaArmazenado({
    Key key,
    
    @required this.documents,
    @required this.initialPosition,
    @required this.pinLocationIcon
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final BitmapDescriptor pinLocationIcon;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      compassEnabled: true,
      onMapCreated: (GoogleMapController controller) {
      },
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 14.5
      ),
      markers: documents
        .map((document) => Marker(
          markerId: MarkerId("${document['idArvore']}"),
          icon: pinLocationIcon,
          position: LatLng(
            document['localizacao'].latitude,
            document['localizacao'].longitude
          ),
          infoWindow: InfoWindow(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Descricao(
                    titulo: document['titulo'],
                    descricao: document['descricao'],
                    fotos: document['fotos'],
                    height: document['height'],
                    fotografos: document['fotografos'],
                    categoria: document['categoria'],
                  ))
                );
            },
            title: document['titulo'],
            snippet: document['descricao']
          )
        )).toSet()
    );
  }
}


