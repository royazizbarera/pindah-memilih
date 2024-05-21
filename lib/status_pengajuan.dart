import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/form_pendaftaran.dart';
import 'package:pindah_memilih/footer.dart';
import 'package:pindah_memilih/model/form_pengajuan_model.dart';
import 'package:pindah_memilih/model/status_pengajuan_model.dart';

class StatusPengajuan extends StatefulWidget {
  const StatusPengajuan({super.key});

  @override
  State<StatusPengajuan> createState() => _StatusPengajuanState();
}

class _StatusPengajuanState extends State<StatusPengajuan> {
  Timer _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
  FormPengajuanModel formPengajuanModel = FormPengajuanModel.getInstance();
  int currentStep = 0;

  List<Map<String, dynamic>> data = StatusPengajuanModel.data;

  TextStyle titleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      currentStep = StatusPengajuanModel.currentStep;
      if (formPengajuanModel.terkirim) {
        data = StatusPengajuanModel.data;
        if (currentStep < data.length) {
          _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
            setState(() {
              currentStep = StatusPengajuanModel.nextStep(currentStep);
            });
          });
        }
      } else {
        StatusPengajuanModel.clear();
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget gap = const SizedBox(height: 24);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        formPendaftaran(),
        gap,
        if (formPengajuanModel.terkirim) status(),
        gap,
        if (formPengajuanModel.terkirim && currentStep >= 4) lokasiTPS(),
        gap,
        const Footer(),
      ],
    );
  }

  Widget status() {
    Widget gap = const SizedBox(width: 96);
    return Container(
      width: 1394,
      height: 669,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF0EF),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 72.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < data.length; i++) ...[
                  statusPengajuan(i, data[i]['title'], data[i]['status'],
                      data[i]['detail']),
                  if (i != data.length - 1) gap
                ],
              ],
            ),
            if (currentStep == 4) ...[
              SizedBox(
                height: 56,
                width: 56,
                child: Image.asset('assets/images/arrow_down.png'),
              ),
              SizedBox(
                width: 300.0,
                child: Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'Pengajuan selesai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Lihat TPS terbaru dibawah'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget statusPengajuan(int step, String title, Status status, String detail) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        const SizedBox(height: 24),
        circleStatus(status),
        const SizedBox(height: 24),
        if (currentStep == step) ...[
          SizedBox(
            height: 56,
            width: 56,
            child: Image.asset('assets/images/arrow_down.png'),
          ),
          SizedBox(
            width: 300.0,
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ]
      ],
    );
  }

  Widget circleStatus(Status status) {
    late Color color;
    late IconData iconData;
    switch (status) {
      case Status.berhasil:
        color = Colors.green;
        iconData = Icons.check;
        break;
      case Status.diproses:
        color = Colors.amber;
        iconData = Icons.access_time_outlined;
        break;
      case Status.dibatalkan:
        color = Colors.red;
        iconData = Icons.close;
        break;
      case Status.belumDiproses:
        color = Colors.grey;
        iconData = Icons.pending_outlined;
        break;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget formPendaftaran() {
    Widget gap = const SizedBox(height: 10);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header form
          Container(
            width: 872,
            decoration: BoxDecoration(
              color: Color(0xFFFFF0EF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title

                  Text(
                    formPengajuanModel.terkirim
                        ? 'Formulir pendaftaran pengajuan berhasil diajukan'
                        : 'Formulir pendaftaran pengajuan belum diajukan',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gap,
                  // Button
                  FilledButton(
                    onPressed: !formPengajuanModel.terkirim
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  width: 920,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  child: const FormPendaftaran(),
                                ),
                              ),
                            ).then((value) => setState(() {}));
                          },
                    child: const Text('Lihat formulir pengajuan'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget lokasiTPS() {
    FormPengajuanModel formPengajuanModel = FormPengajuanModel.getInstance();
    Widget gap = const SizedBox(height: 24);
    return SizedBox(
      width: 1136,
      // height: 948,
      child: Card(
        color: Color(0xFFFFF0EF),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'TPS 069',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              gap,
              SizedBox(
                width: 867,
                height: 367,
                child: Image.asset('assets/images/map_tps.png'),
              ),
              gap,
              SizedBox(
                width: 867,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          textInfoTPS('Nama Pemilih'),
                          textInfoTPS(formPengajuanModel.namaLengkap.text),
                          const SizedBox(height: 18),
                          textInfoTPS('Nomor Induk Kependudukan (NIK)'),
                          textInfoTPS(formPengajuanModel.nik.text),
                          const SizedBox(height: 18),
                          textInfoTPS('Tempat Pemungutan Suara (TPS)'),
                          textInfoTPS(
                              'TPS 069, Jl. Gegerkalong Hilir, Ciwaruga, Kec. Parongpong, Kabupaten Bandung Barat, Jawa Barat 40559'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInfoTPS(String text) {
    TextStyle textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    return Text(text, style: textStyle);
  }
}
