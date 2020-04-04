import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DefinirLocal extends StatefulWidget {
  @override
  _DefinirLocalState createState() => _DefinirLocalState();
}

class _DefinirLocalState extends State<DefinirLocal> {
  Set<Marker> _marker = Set();
  GoogleMapController controller;
  LatLng localizacao;

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
            Navigator.pop(context);
          });
        },
      ),

      body: GoogleMap(
        compassEnabled: true,
        myLocationEnabled: true,
        markers: _marker,
        onTap: (latlng) {
          setState(() {
            Marker resultMarker = Marker(
              markerId: MarkerId('marcador'),
              position: LatLng(latlng.latitude,
              latlng.longitude),
            );

            _marker.add(resultMarker);
            localizacao = latlng;
          });
        },
        onMapCreated: (control) {
          controller = control;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(-5.565041, -42.608059),
          zoom: 15.5
        ),
      )
    );
  }

  // void mostrarMensagem(BuildContext context) {
  //   var alert = AlertDialog(
  //     title: Text("Terremotos"),
  //     content: Text("Deseja definir o local selecionado?"),
  //     actions: <Widget>[
  //       FlatButton(
  //         color: Colors.red,
  //         onPressed: () => Navigator.pop(context),
  //         child: Text(
  //           "Cancelar"
  //         ),
  //       ),
  //       FlatButton(
  //         color: Colors.green,
  //         onPressed: () => Navigator.pop(context),
  //         child: Text(
  //           "Confirmar"
  //         ),
  //       )
  //     ],
  //   );

  //   showDialog(context: context, builder: (_){
  //         return alert;
  //       }
  //     );
  //   }
  }
