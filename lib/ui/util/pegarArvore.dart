import 'dart:async';
import 'package:http/http.dart' as http;

Future<http.Response> pegarDados() {
  return http.get('https://raw.githubusercontent.com/CarlosDaniel0/arboris/master/arvores.json');
}

class Arvore {
  int id;
  String nome;
  String descricao;
  String fotografos;
  List<String> fotos;
  List<double> localizacao;
  String categoria;
}

String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }