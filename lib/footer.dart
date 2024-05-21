import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    Widget gap = const SizedBox(height: 24);
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 108),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset('assets/images/large-logo-pindah-memilih.png'),
            ),
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explore',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      gap,
                      const Text('Tentang Pindah Memilih'),
                      gap,
                      const Text('Disclaimer'),
                      gap,
                      const Text('Tim Kami'),
                    ],
                  ),
                ),
                // Right Column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hubungi Kami',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      gap,
                      const Text('contact@pindahmemilih.id'),
                      gap,
                      const Text('Instagram'),
                      gap,
                      const Text('Twitter'),
                    ],
                  ),
                ),
              ],
            ),
            gap,
            const Divider(),
            gap,
            const SizedBox(
              width: 400,
              child: Text(
                'Pindah Memilih merupakan sebuah aplikasi milik pemerintah untuk membantu masyarakat melakukan pemindahan TPS secara online.'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
