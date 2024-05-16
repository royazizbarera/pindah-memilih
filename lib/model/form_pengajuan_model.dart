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

  FormPengajuanModel({
    this.ktpKk,
    this.formulirModelA,
    this.dokumenAlasanPindah,
  });

  bool isFormFilledIn() {
    return namaLengkap.text.isNotEmpty &&
        nik.text.isNotEmpty &&
        ttl.text.isNotEmpty &&
        alamat.text.isNotEmpty &&
        agama.text.isNotEmpty &&
        alasanPindah.text.isNotEmpty &&
        ktpKk != null &&
        formulirModelA != null &&
        dokumenAlasanPindah != null;
  }

  void dispose() {
    namaLengkap.dispose();
    nik.dispose();
    ttl.dispose();
    alamat.dispose();
    agama.dispose();
    alasanPindah.dispose();
  }
}
