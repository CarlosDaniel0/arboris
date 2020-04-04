import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sobre Nós"),
      ),

      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Icon(Icons.people),
                subtitle: Text("Este aplicativo é resultado de um projeto tecnológico desenvolvido pelo alunos do curso Técnico em Informática ofertado pela Secretaria de Educação do Estado do Piauí (SEDUC-PI) na cidade de Monsenhor Gil no período de 2018 à 2020.", style: texto()),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Text("Alunos:", style: titulo(), textAlign: TextAlign.center,),
                subtitle: Text('''
ALISSON HENRIQUE
ANA DEBORA
ANDERSON RODRIGUES
ANTONIO LUIS
CARLOS DANIEL
CARLOS EDUARDO
DAIANE ISABEL
DOUGLAS DANIEL
GABRIEL DA SILVA
HILARIO TIAGO
JAINARA DA COSTA
JESSICA MARIA
JONATHAS VINICIUS
KARINE GABRIELLY
LARISSA DE CASSIA
MARCOS FELIPE
MARCUS VINICIUS
MARIA BEATRIZ
MAYLLA PEREIRA
PAULO WENDEL
RAFAEL CONCEICAO
RAIRAN STENIO
SAIMON RHADESK
THAYS MONIQUE
VANESSA FRANCISCA
              ''', style: alunos(),),
              )
            ),
          )
        ],
      ),
    );
  }

  TextStyle titulo() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  TextStyle texto() {
    return TextStyle(
      fontSize: 18
    );
  }

  TextStyle alunos() {
    return TextStyle(
      fontSize: 16
    );
  }
}