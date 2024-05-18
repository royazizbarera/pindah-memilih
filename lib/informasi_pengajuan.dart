import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/hitung_mundur.dart';
import 'package:pindah_memilih/components/informasi_pengajuan_content.dart';
import 'package:pindah_memilih/footer.dart';

class InformasiPengajuan extends StatefulWidget {
  const InformasiPengajuan({super.key});

  @override
  State<InformasiPengajuan> createState() => _InformasiPengajuanState();
}

class _InformasiPengajuanState extends State<InformasiPengajuan> {
  @override
  Widget build(BuildContext context) {
    Widget gap = const SizedBox(height: 24);
    return Column(
      children: [
        const HitungMundur(),
        gap,
        const InformasiPengajuanContent(),
        gap,
        const Footer()
      ],
    );
  }
}
