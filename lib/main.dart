import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pindah_memilih/beranda.dart';
import 'package:pindah_memilih/components/header.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/daftar.dart';
import 'package:pindah_memilih/firebase_options.dart';
import 'package:pindah_memilih/informasi_pengajuan.dart';
import 'package:pindah_memilih/masuk.dart';
import 'package:pindah_memilih/pengajuan.dart';
import 'package:pindah_memilih/status_pengajuan.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() async {
    // Initialize
    BindingBase.debugZoneErrorsAreFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.web,
    );
    runApp(
      ChangeNotifierProvider(
        create: (context) => HeaderState(),
        child: const MainApp(),
      ),
    );
  }, (error, stack) {});
  // runApp(const MyApp());
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
            Provider.of<HeaderState>(context, listen: false).setIndex(4);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      /// Warna yang diinginkan ini
      // colorSchemeSeed: Color(0xFFBF002A),
      /// Tapi yang ini yang kebuat pas di figma
      colorSchemeSeed: const Color(0xFF904A4A),
      useMaterial3: true,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
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
    Future.microtask(() {
      if (!Provider.of<HeaderState>(context, listen: false).login) {
        if (Provider.of<HeaderState>(context, listen: false).selectedIndex ==
                1 ||
            Provider.of<HeaderState>(context, listen: false).selectedIndex ==
                2) {
          Provider.of<HeaderState>(context, listen: false).setIndex(4);
        }
      }
    });
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
      case 4:
        return const Masuk();
      case 5:
        return const Daftar();
      default:
        return const Placeholder();
    }
  }
}
