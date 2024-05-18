import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/hitung_mundur.dart';
import 'package:pindah_memilih/components/informasi_pengajuan_content.dart';
import 'package:pindah_memilih/footer.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    Widget gap = const SizedBox(height: 24);
    return Column(
      children: [
        const HitungMundur(),
        const SizedBox(
          height: 600.0,
          child: Placeholder(),
        ),
        gap,
        const InformasiPengajuanContent(),
        gap,
        const Footer()
      ],
    );
  }
}
