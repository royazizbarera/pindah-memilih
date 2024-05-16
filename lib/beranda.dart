import 'package:flutter/material.dart';

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Beranda'),
        Placeholder(),
        for (int i = 0; i < 100; i++) Text('Item $i'),
      ],
    );
  }
}
