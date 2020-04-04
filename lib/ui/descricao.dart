import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';

class Descricao extends StatelessWidget {
  const Descricao({
    Key key,
    @required this.titulo,
    @required this.descricao,
    @required this.categoria,
    @required this.height,
    @required this.fotos,
    @required this.fotografos
  }) : super(key: key);

  final String titulo;
  final String fotografos;
  final int height;
  final String descricao;
  final String categoria;
  final List fotos;
  @override
  Widget build(BuildContext context) {
    double altura = height == null ? Image.network(fotos[0]).height : height.toDouble();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titulo),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
        fotos.length > 1 ? CarouselSlider(
            items: <Widget>[
              for (int i = 0; i < fotos.length; i++) 
                PhotoView(
                    imageProvider: NetworkImage(fotos[i]),
                  )
            ],
            height: altura,
            autoPlay: false,
            onPageChanged: (item) {
            },
          ) : Image.network(
                  fotos[0], 
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.low,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loading) {
                    if (loading == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loading.expectedTotalBytes != null ? 
                          loading.cumulativeBytesLoaded / loading.expectedTotalBytes
                          : null,
                        ),
                      );
                  }),

            Column(
              children: <Widget>[
                
                fotografos != null ?
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 5),
                  child: Row(
                    children: <Widget>[
                      Text("Foto: ", style: texto()), Text(" "), Text("$fotografos", style: forte())
                    ],
                  ),
                ) :
                Container(),

                ListTile(
                  title: Text("Descrição", style: forte()),
                  subtitle: Text(descricao, style: texto()),
                ),
                ListTile(
                  title: Text("Categoria", style: forte()),
                  subtitle: Text(categoria, style: texto()),
                ),
              ],
            )
          ],
      ),
    );
  }

  TextStyle forte() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    );
  }

  TextStyle texto() {
    return TextStyle(
      fontSize: 18,
    );
  }
}
