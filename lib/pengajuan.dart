import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pindah_memilih/model/form_pengajuan_model.dart';

class Pengajuan extends StatefulWidget {
  const Pengajuan({super.key});

  @override
  State<Pengajuan> createState() => _PengajuanState();
}

class _PengajuanState extends State<Pengajuan> {
  double widhtContent = 872.0;
  bool persetujuanValue = true;
  bool terkirim = false;
  FormPengajuanModel formPengajuanModel = FormPengajuanModel();

  @override
  void dispose() {
    formPengajuanModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 72.0),
      child: Column(
        children: [
          formPendaftaran(),
          const Text('Footer'),
        ],
      ),
    );
  }

  Widget formPendaftaran() {
    double paddingContent = 24.0;
    return Padding(
      padding: EdgeInsets.all(paddingContent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!terkirim) headerForm(),
          SizedBox(height: paddingContent),
          form(),
        ],
      ),
    );
  }

  Widget form() {
    return SizedBox(
      width: widhtContent,
      child: Column(
        children: [
          terkirim
              ? const Text('Pendaftaran Pengajuan Berhasil')
              : const Text('Pendaftaran Pengajuan'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left
              formLeft(),
              // Right
              rightForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget rightForm() {
    Widget gap = const SizedBox(height: 24.0);
    Widget buttonKirim = FilledButton(
      onPressed: persetujuanValue
          ? () {
              if (formPengajuanModel.isFormFilledIn()) {
                showDialog(
                  context: context,
                  builder: (context) => SizedBox(
                    width: 312.0,
                    child: AlertDialog(
                      title: const Text('Peringatan'),
                      content: const Text(
                          'Pastikan data yang Anda kirimkan sudah benar!'),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              terkirim = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Text('Kirim'),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Batalkan'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: const Text(
                        'Formulir belum lengkap! Silahkan lengkapi formulir terlebih dahulu.'),
                  ),
                );
              }
            }
          : null,
      child: const Text('Kirim'),
    );
    Widget buttonBatalkanPendaftaranPengajuan = OutlinedButton(
      onPressed: () {
        setState(() {
          terkirim = false;
        });
      },
      child: const Text('Batalkan Pendaftaran Pengajuan'),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        uploadFile(
            title: 'Formulir Model A (*Bukti terdaftar pemilih di DPT)',
            image: formPengajuanModel.formulirModelA,
            onImagePicked: (image) {
              setState(() {
                formPengajuanModel.formulirModelA = image;
              });
            }),
        gap,
        textFieldForm(
          labelText: 'Alasan Pindah',
          textController: formPengajuanModel.alasanPindah,
        ),
        gap,
        uploadFile(
            title: 'Dokumen Pendukung Alasan Pindah',
            image: formPengajuanModel.dokumenAlasanPindah,
            onImagePicked: (image) {
              setState(() {
                formPengajuanModel.dokumenAlasanPindah = image;
              });
            }),
        gap,
        persetujuan(),
        gap,
        SizedBox(
          height: 40,
          child: terkirim ? buttonBatalkanPendaftaranPengajuan : buttonKirim,
        )
      ],
    );
  }

  Widget formLeft() {
    Widget gap = const SizedBox(height: 24.0);
    return Column(
      children: [
        textFieldForm(
          labelText: 'Nama Lengkap',
          textController: formPengajuanModel.namaLengkap,
        ),
        gap,
        textFieldForm(
          labelText: 'Nomor Induk Keluarga',
          textController: formPengajuanModel.nik,
        ),
        gap,
        textFieldForm(
          labelText: 'Tempat/Tanggal Lahir',
          textController: formPengajuanModel.ttl,
        ),
        gap,
        textFieldForm(
          labelText: 'Alamat',
          textController: formPengajuanModel.alamat,
        ),
        gap,
        textFieldForm(
          labelText: 'Agama',
          textController: formPengajuanModel.agama,
        ),
        gap,
        uploadFile(
            title: 'Foto KTP/KK',
            image: formPengajuanModel.ktpKk,
            onImagePicked: (image) {
              setState(() {
                formPengajuanModel.ktpKk = image;
              });
            }),
      ],
    );
  }

  Widget persetujuan() {
    return SizedBox(
      width: 400.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: Checkbox(
                value: persetujuanValue,
                onChanged: (value) {
                  setState(() {
                    persetujuanValue = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Saya menyetujui syarat dan ketentuan yang berlaku',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadFile(
      {required String title,
      Image? image,
      required void Function(Image?) onImagePicked}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: 400.0,
          child: OutlinedButton(
            onPressed: () async {
              Image? pickedImage = await ImagePickerWeb.getImageAsWidget();
              if (pickedImage != null) {
                onImagePicked(pickedImage);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.file_upload_outlined),
                const SizedBox(width: 8.0),
                image != null
                    ? MiddleEllipsisText(text: image.semanticLabel!)
                    : const Text('Tambahkan File'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        Container(
            width: 240.0,
            height: 138.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.30),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: InkWell(
              child: image ?? Image.asset('assets/images/Thumbnail.png'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: SizedBox(
                      child: image,
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }

  Widget textFieldForm({
    required String labelText,
    required TextEditingController textController,
  }) {
    return SizedBox(
      width: 400.0,
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  Widget headerForm() {
    return Container(
      width: widhtContent,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hai, Warga Negara Indonesia yang terhormat!\n'),
            Text(
                'Apakah Anda ingin memilih di Pemilu, tetapi tidak memungkinkan untuk memilih di TPS Anda yang dulu? Kami siap membantu Anda untuk memindahkan TPS Anda!\nSebelum Anda mengisi formulir pemindahan TPS, mohon perhatikan beberapa hal berikut:\n1. Pastikan Anda memenuhi syarat pemindahan TPS sesuai dengan peraturan yang berlaku.\n2. Isi formulir dengan informasi yang benar dan jelas untuk mempermudah proses verifikasi.\n3. Mohon tunggu konfirmasi dari kami setelah mengirimkan formulir.\nKami berkomitmen untuk membantu Anda dalam proses pemindahan TPS agar Anda dapat menggunakan hak pilih Anda dengan mudah dan nyaman.\n'),
          ],
        ),
      ),
    );
  }
}

class MiddleEllipsisText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLength;

  const MiddleEllipsisText({
    super.key,
    required this.text,
    this.style,
    this.maxLength = 14,
  });

  @override
  Widget build(BuildContext context) {
    if (text.length <= maxLength) {
      return Text(text, style: style);
    }

    int halfLength = (maxLength / 2).floor();
    String startText = text.substring(0, halfLength);
    String endText = text.substring(text.length - halfLength);

    return IntrinsicWidth(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: startText, style: style),
            const TextSpan(text: '...'),
            TextSpan(text: endText, style: style),
          ],
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
