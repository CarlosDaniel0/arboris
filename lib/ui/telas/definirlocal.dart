import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class DefinirLocal extends StatefulWidget {
  DefinirLocal({Key key, @required this.local}) : super(key:key);
  final LatLng local;
  @override
  _DefinirLocalState createState() => _DefinirLocalState(posicao: local);
}

class _DefinirLocalState extends State<DefinirLocal> {
  _DefinirLocalState({@required this.posicao});
  final LatLng posicao;
  LatLng definirLocal;
  MapController mapController;
  String mostrar;

  @override
  void initState() {
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Difinir local no mapa"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Navigator.pop(context, definirLocal);
          });
        },
      ),

      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: posicao,
                zoom: 15.0,
                maxZoom: 18.0,
                onTap: (latlng) {
                  setState(() {
                    definirLocal = latlng;
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
                MarkerLayerOptions(            
                  markers: [
                      definirLocal != null ? definirMarcador(definirLocal) : Marker() 
                        ]
                      ),
                    ]
                ),
          ),

          mostrar == null ? Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Colors.blue),
                title: Text("Dê um zoom para carregar o mapa. Clique no local onde está a árvore"),
                trailing: GestureDetector(
                  child: Icon(Icons.cancel, color: Colors.red),
                  onTap: () {
                    setState(() {
                      mostrar = "nao";
                    });
                  },
                  ),
              ),
            )
          ) : Container()
        ],
      )
    );
  }

  definirMarcador(LatLng local) {
    return Marker(
      width: 65.0,
      height: 65.0,
      point: local,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      builder: (context) => Container(
        child:
          IconButton(
              iconSize: 55,
              icon: 
              Icon(Icons.location_on, color: Colors.red),
              // FaIcon(FontAwesomeIcons.tree, color: Colors.green), 
              onPressed: () {
              }),
          ),
      );
  }
  }
