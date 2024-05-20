import 'package:flutter/material.dart' show Image, TextEditingController;

class FormPengajuanModel {
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController ttl = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController agama = TextEditingController();
  TextEditingController alasanPindah = TextEditingController();

  Image? ktpKk;
  Image? formulirModelA;
  Image? dokumenAlasanPindah;

  bool menyetujuiPersyaratan = false;
  bool terkirim = false;

  static FormPengajuanModel? instance;

  FormPengajuanModel({
    this.ktpKk,
    this.formulirModelA,
    this.dokumenAlasanPindah,
  });

  // singleton
  static FormPengajuanModel getInstance() {
    instance ??= FormPengajuanModel();
    return instance!;
  }

  bool isFormFilledIn() {
    return namaLengkap.text.isNotEmpty &&
        nik.text.isNotEmpty &&
        ttl.text.isNotEmpty &&
        alamat.text.isNotEmpty &&
        agama.text.isNotEmpty &&
        alasanPindah.text.isNotEmpty &&
        ktpKk != null &&
        formulirModelA != null &&
        dokumenAlasanPindah != null &&
        menyetujuiPersyaratan;
  }

  void clear() {
    namaLengkap.clear();
    nik.clear();
    ttl.clear();
    alamat.clear();
    agama.clear();
    alasanPindah.clear();

    ktpKk = null;
    formulirModelA = null;
    dokumenAlasanPindah = null;
    terkirim = false;
    menyetujuiPersyaratan = false;
  }

  // fill data
  void fillDataDummy() {
    namaLengkap.text = 'Roy Aziz Barera';
    nik.text = '3209090213450003';
    ttl.text = 'Jakarta, 1 Januari 2000';
    alamat.text = 'Jl. Jalan, RT 01 RW 01, Jakarta';
    agama.text = 'Islam';
    alasanPindah.text = 'Kuliah di Bandung / Luar Kota';
    ktpKk = Image.asset('assets/images/ktp.png');
    formulirModelA = Image.asset('assets/images/form-model-a.png');
    dokumenAlasanPindah = Image.asset('assets/images/keterangan-pindah.png');
  }
}
