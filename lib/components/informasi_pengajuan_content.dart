import 'package:flutter/material.dart';

class InformasiPengajuanContent extends StatefulWidget {
  const InformasiPengajuanContent({super.key});

  @override
  State<InformasiPengajuanContent> createState() =>
      _InformasiPengajuanContentState();
}

class _InformasiPengajuanContentState extends State<InformasiPengajuanContent> {
  double iconSize = 65;

  List<Map<String, dynamic>> persyaratan = [
    {
      'icon': Icons.description_outlined,
      'title':
          'Persyaratan yang harus dibawa saat melaporkan diri untuk pindah memilih',
      'persyaratan': [
        'Menunjukkan KTP-el atau KK',
        'Melampirkan salinan formulir Model A-Tanda Bukti Terdaftar sebagai Pemilih dalam DPT di TPS asal.',
      ],
    },
    {
      'icon': Icons.recycling_rounded,
      'title': 'Persyaratan yang harus dipenuhi saat pindah memilih',
      'persyaratan': [
        'Pemilih yang pindah memilih harus melapor ke petugas KPPS di TPS yang baru.',
        'Pemilih yang pindah memilih harus menunjukkan KTP-el atau KK.',
        'Pemilih yang pindah memilih harus melampirkan salinan formulir Model A-Tanda Bukti Terdaftar sebagai Pemilih dalam DPT di TPS asal.',
      ],
    },
    {
      'icon': Icons.calendar_month_outlined,
      'title': 'Waktu pemilih melaporkan diri untuk pindah memilih',
      'persyaratan': [
        'Untuk menggunakan hak pilihnya di TPS tujuan, Pemilih yang terdaftar dalam DPTb dapat melaporkan kepada PPS, PPK, atau KPU Kabupaten/Kota tempat asal atau tempat tujuan paling lambat 7 (tujuh) hari sebelum hari pemungutan suara.',
      ],
    },
    {
      'icon': Icons.task_outlined,
      'title': 'Jenis pemilihan yang dapat dipilih ',
      'persyaratan': [
        'Calon anggota DPR jika pindah memilih ke kabupaten/kota lain di dalam 1 (satu) provinsi dan daerah pemilihan DPR;',
        'Calon anggota DPD jika pindah memilih ke kabupaten/kota lain di dalam 1 (satu) provinsi;',
        'Pasangan calon Presiden dan Wakil Presiden jika pindah memilih ke provinsi lain atau pindah memilih ke suatu negara;',
        'Calon anggota DPRD Provinsi jika pindah memilih ke kecamatan atau kabupaten/kota lain di dalam 1 (satu) provinsi dan daerah pemilihan DPRD Provinsi; dan/atau',
        'Calon anggota DPRD Kabupaten/Kota jika pindah memilih ke desa/kelurahan atau kecamatan lain di dalam 1 (satu) kabupaten/kota dan daerah pemilihan DPRD Kabupaten/Kota.',
      ],
    },
  ];

  List<IconData> icon = [
    Icons.description_outlined,
    Icons.recycling_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    Widget gap = const SizedBox(height: 24);
    return Column(
      children: [
        for (int i = 0; i < persyaratan.length; i++) ...[
          cardInformation(persyaratan[i]),
          gap
        ],
      ],
    );
  }

  SizedBox cardInformation(Map<String, dynamic> persyaratan) {
    return SizedBox(
      width: 917,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    persyaratan['icon'],
                    size: iconSize,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      persyaratan['title'],
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < persyaratan['persyaratan'].length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (persyaratan['persyaratan'].length > 1)
                                  Text(
                                    "${i + 1}. ",
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    persyaratan['persyaratan'][i],
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
