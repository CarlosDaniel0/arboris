import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Descricao extends StatelessWidget {
  const Descricao({
    Key key,
    @required this.titulo,
    @required this.descricao,
    @required this.categoria,
    @required this.height,
    @required this.fotos,
    @required this.fotografos,
    this.scrollController,
    this.cx,
  }) : super(key: key);

  final String titulo;
  final String fotografos;
  final int height;
  final String descricao;
  final String categoria;
  final List fotos;
  final BuildContext cx;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    double altura = height == null ? Image.network(fotos[0]).height : height.toDouble();
    return MediaQuery.removePadding(
      removeTop: true,
      context: cx, 
      child: ListView(
      shrinkWrap: true,
      controller: scrollController,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: 
            Container(
              width: 35,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 25),
          child: Center(child: Text("$titulo", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)),
        ),

        carrosselImagens(fotos,altura),
        
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
      
        SizedBox(
          height: 15,
        ),

        ListTile(
          title: Text("Descrição", style: forte()),
          subtitle: Text(descricao, style: texto(), textAlign: TextAlign.justify,),
        ),
        Divider(height: 5.0),
        ListTile(
          title: Text("Categoria", style: forte()),
          subtitle: Text(categoria, style: texto()),
        ),

        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text("Fonte: Wikipédia", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        )
      ],
    )
    );
  }

  Widget carrosselImagens(List imagens, double altura) {
    Widget widget;
    
    if (imagens.length > 1) {
      widget = Container(
      child: CarouselSlider.builder(
        height: altura,
        scrollDirection: Axis.horizontal,
        itemCount: imagens.length, 
        itemBuilder: (context, i){
          return GestureDetector(
            onTap: () {
            },
            child: Image.network(
              fotos[i],
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loading) {
              if (loading == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loading.expectedTotalBytes != null ? 
                      loading.cumulativeBytesLoaded / loading.expectedTotalBytes
                        : null,
                        ),
                      );
              }
            ),
          );
        }),
    );
    } else {
      widget = Container(
        child: GestureDetector(
          onTap: () {
          },
          child: Image.network(
            fotos[0],
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loading) {
            if (loading == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loading.expectedTotalBytes != null ? 
                    loading.cumulativeBytesLoaded / loading.expectedTotalBytes
                      : null,
                      ),
                    );
                }
              ),
        ),
      );
    }
    return widget;
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

class ModoGaleria extends StatefulWidget {
  final List imagens;
  final int id;
  ModoGaleria({Key key, this.imagens, this.id}):super(key: key);
  @override
  _ModoGaleriaState createState() => _ModoGaleriaState(id: id, imagens: imagens);
}

class _ModoGaleriaState extends State<ModoGaleria> {
  _ModoGaleriaState({this.imagens, this.id});
  final List<String>imagens;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: <Widget>[
          for(int i = 0; i < imagens.length; i++)
            PhotoView(imageProvider: NetworkImage(imagens[i]))
        ],
      ),
    );
  }
}
