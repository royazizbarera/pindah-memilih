class StatusPengajuanModel {
  static List<Map<String, dynamic>> data = [
    {
      'title': 'Verifikasi Dokumen',
      'status': Status.diproses,
      'detail': 'Memverifikasi dokumen pemilih, Perkiraan 5 menit',
    },
    {
      'title': 'Menunggu Persetujuan',
      'status': Status.belumDiproses,
      'detail': 'Menunggu persetujuan dari pihak terkait, Perkiraan 1 hari',
    },
    {
      'title': 'Pencarian TPS',
      'status': Status.belumDiproses,
      'detail': 'Pencarian TPS tidak ditemukan, Perkiraan 1 hari',
    },
    {
      'title': 'Pengajuan Selesai',
      'status': Status.belumDiproses,
      'detail': 'Pengajuan selesai, Perkiraan 1 hari',
    },
  ];

  static int currentStep = 0;

  StatusPengajuanModel();

  // singleton
  static StatusPengajuanModel? instance;

  // static StatusPengajuanModel getInstance() {
  //   instance ??= StatusPengajuanModel();
  //   return instance!;
  // }

  static void clear() {
    instance = null;
  }

  // next step
  static int nextStep(int step) {
    int nextStep = step + 1;
    if (nextStep < data.length) {
      data[nextStep]['status'] = Status.diproses;
    }
    if (step < data.length) {
      data[step]['status'] = Status.berhasil;
    }
    currentStep = nextStep >= data.length ? 4 : nextStep;
    return currentStep;
  }
}

// status enum
enum Status {
  belumDiproses,
  diproses,
  berhasil,
  dibatalkan,
}
