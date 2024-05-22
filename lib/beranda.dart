import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/components/hitung_mundur.dart';
import 'package:pindah_memilih/components/informasi_pengajuan_content.dart';
import 'package:pindah_memilih/footer.dart';
import 'package:provider/provider.dart';

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
        hero(),
        gap,
        const InformasiPengajuanContent(),
        gap,
        const Footer()
      ],
    );
  }

  Widget hero() {
    return Container(
      height: 600.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: const Color(0xFFFFF0EF),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 400,
                    child: Text(
                      'Bingung untuk melakukan pemindahan TPS karena sedang berada diluar domisili TPS?\n\nAyo pindahkan pemilihan TPS Anda sekarang!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<HeaderState>(context, listen: false)
                            .setIndex(1);
                      });
                    },
                    child: const Text('Ajukan pemindahan'),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              SvgPicture.asset('assets/images/voting-amico.svg'),
            ],
          )
        ],
      ),
    );
  }
}
