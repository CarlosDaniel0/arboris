import 'package:flutter/material.dart';
import 'package:arboris/ui/home.dart';

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
