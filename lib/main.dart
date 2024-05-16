// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/header.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      colorSchemeSeed: Color(0xFFBF002A),
      useMaterial3: true,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: Header(
            selectedItem: 0,
            
          ),
        ),
        body: Center(
          child: Placeholder(),
        ),
      ),
    );
  }
}
