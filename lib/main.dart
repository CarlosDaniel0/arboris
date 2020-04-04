import 'package:flutter/material.dart';
import 'package:projeto_arboris/ui/home.dart';

void main() => runApp(
    MaterialApp(
      home: Home(),
      title: "Arboris",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    )
);
