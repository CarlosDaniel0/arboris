import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SobreOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre o App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            children: <Widget>[
              // Descrição do app
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                    title: Text("Esse app utiliza a localização do usuário para mapear árvores, sendo o uso desses dados restritos apenas a essa finalidade. Informações sugeridas pelos colaboradores serão avaliadas pelos desenvolvedores antes de serem disponibilizadas no app."),
                    subtitle: Text("Versão: 1.0"),
                  ),
                ),
              ),

              //  Imagens utilizadas
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                   title: Center(
                     child: Column(
                       children: <Widget>[
                         Icon(Icons.image),
                         Text("Imagens utilizadas pelo app disponível no link abaixo:"),
                       ],
                     ),
                   ),
                   subtitle: 
                    FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        launch("https://drive.google.com/drive/folders/1QuQ-9eSuAs0UYsxOFNTdGnxSXXHFJKuf");
                      }, 
                      child: Text("Ver Imagens", style: TextStyle(color: Colors.white),))
                  ),
                ),
              ),

              // Projeto GitHub
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                   title: Center(
                     child: Column(
                       children: <Widget>[
                         FaIcon(FontAwesomeIcons.github),
                         Text("Esse app é um projeto Colaborativo e Open Source. Disponível no GitHub. Clique no link abaixo para saber mais."),
                       ],
                     ),
                   ),
                   subtitle: 
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        launch("https://github.com/CarlosDaniel0/arboris");
                      }, 
                      child: Text("Ver Projeto", style: TextStyle(color: Colors.white),))
                  ),
                ),
              ),

              //  Fale conosco.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                    title: Column(
                      children: <Widget>[
                        Icon(Icons.contact_mail),
                        Text("Alguma dúvida ou sugestão? Fale com a gente. Email para contato:")
                      ],
                    ),
                    subtitle: 
                      FlatButton(
                        child: Text("projetoarboris@gmail.com"),
                        onPressed: () {
                          _launchURL('projetoarboris@gmail.com', 'Dúvidas ou Sugestões', '');
                        },
                      )
                  ),
                ),
              ),

              //  Direito autoral da imagem utilizada.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                    title: Center(
                      child: Column(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.creativeCommons),
                          Text("O icone utilizado no marcador está disponível sob licença Creative Commons pelo autor: brgfx, disponível no link abaixo:"),
                        ],
                      )),
                    subtitle:
                      FlatButton(
                        color: Colors.green,
                        child: Text("Clique aqui", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          launch("https://br.freepik.com/vetores-gratis/conjunto-de-design-de-arvore-diferente_3875712.htm#page=1&query=tree&position=26");
                        },
                    )
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

    _launchURL(String paraEmail, String assunto, String corpo) async {
    var url = 'mailto:$paraEmail?subject=$assunto&body=$corpo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}