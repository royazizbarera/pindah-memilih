import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pindah_memilih/model/form_pengajuan_model.dart';

class FormPendaftaran extends StatefulWidget {
  const FormPendaftaran({super.key});

  @override
  State<FormPendaftaran> createState() => _FormPendaftaranState();
}

class _FormPendaftaranState extends State<FormPendaftaran> {
  double widhtContent = 872.0;
  FormPengajuanModel formPengajuanModel = FormPengajuanModel.getInstance();

  @override
  Widget build(BuildContext context) {
    return Center(child: form());
  }

  Widget form() {
    return SizedBox(
      width: widhtContent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          formPengajuanModel.terkirim
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
      onPressed: formPengajuanModel.menyetujuiPersyaratan
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
                              formPengajuanModel.terkirim = true;
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
          formPengajuanModel.clear();
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
        // persetujuan(),
        // gap,
        SizedBox(
          height: 40,
          child: formPengajuanModel.terkirim
              ? buttonBatalkanPendaftaranPengajuan
              : buttonKirim,
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
          labelText: 'Nomor Induk Kependudukan',
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
          },
        ),
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
                value: formPengajuanModel.menyetujuiPersyaratan,
                onChanged: (value) {
                  setState(() {
                    formPengajuanModel.menyetujuiPersyaratan = value!;
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
    String imageLabel = 'Tambahkan File';
    if (image != null) {
      var imageProvider = image.image;
      if (imageProvider is AssetImage) {
        imageLabel = imageProvider.assetName;
      } else {
        imageLabel = image.semanticLabel!;
      }
    }
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
            onPressed: formPengajuanModel.terkirim
                ? null
                : () async {
                    Image? pickedImage =
                        await ImagePickerWeb.getImageAsWidget();
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
                MiddleEllipsisText(text: imageLabel),
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
          ),
        )
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
        readOnly: formPengajuanModel.terkirim,
        controller: textController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
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
