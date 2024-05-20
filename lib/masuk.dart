import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/header.dart';
import 'package:pindah_memilih/footer.dart';

class Masuk extends StatefulWidget {
  const Masuk({super.key});

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Header(),
        Placeholder(),
        Footer(),
      ],
    );
  }
}
