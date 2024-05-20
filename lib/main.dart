// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:pindah_memilih/beranda.dart';
import 'package:pindah_memilih/components/header.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/informasi_pengajuan.dart';
import 'package:pindah_memilih/pengajuan.dart';
import 'package:pindah_memilih/status_pengajuan.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HeaderState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Future.microtask(() {
        if (!Provider.of<HeaderState>(context, listen: false).login) {
          if (Provider.of<HeaderState>(context, listen: false).selectedIndex ==
                  1 ||
              Provider.of<HeaderState>(context, listen: false).selectedIndex ==
                  2) {
            Provider.of<HeaderState>(context, listen: false).setIndex(0);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      // colorSchemeSeed: Color(0xFFBF002A),
      colorSchemeSeed: Color(0xFF904A4A),
      useMaterial3: true,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: Header(),
              expandedHeight: 68,
              floating: true,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: themeData.colorScheme.onPrimary,
                ),
                child: content(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget content() {
    int selectedIndex =
        Provider.of<HeaderState>(context, listen: true).selectedIndex;
    switch (selectedIndex) {
      case 0:
        return const Beranda();
      case 1:
        return const Pengajuan();
      case 2:
        return const StatusPengajuan();
      case 3:
        return const InformasiPengajuan();
      default:
        return const Placeholder();
    }
  }
}
