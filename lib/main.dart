import 'package:flutter/material.dart';
import 'package:arboris/ui/home.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    List dados = await jsonTerremotos();
     runApp(
      MaterialApp(
        home: Home(dados: dados,),
        title: "Arboris",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
      )
    );
  } catch (e){
    runApp(
      MaterialApp(
        home: Home(error: e.toString(),),
        title: "Arboris",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
      )
    );
  }
 
}

Future<List> jsonTerremotos() async {
  String apiURL = "https://raw.githubusercontent.com/CarlosDaniel0/arboris/master/arvores.json";

  http.Response response = await http.get(apiURL);

  return json.decode(response.body);

}
