import 'dart:async';
import 'package:flutter/material.dart';

class HitungMundur extends StatefulWidget {
  const HitungMundur({super.key});

  @override
  State<HitungMundur> createState() => _HitungMundurState();
}

class _HitungMundurState extends State<HitungMundur> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    // Set the target date and time
    DateTime targetDate = DateTime(2024, 8, 25);
    _duration = targetDate.difference(DateTime.now());

    // Initialize the timer to update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = targetDate.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 433.0,
                  child: Text(
                    'Hitung Mundur Pengumpulan Berkas Pemindahan TPS',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 108),
            time(),
          ],
        ),
      ),
    );
  }

  Widget time() {
    int days = _duration.inDays;
    int hours = _duration.inHours % 24;
    int minutes = _duration.inMinutes % 60;
    int seconds = _duration.inSeconds % 60;

    Widget gap = const SizedBox(width: 24);
    Widget titikDua = Flexible(
      child: Text(
        ':',
        style: TextStyle(
            fontSize: 65, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        timeBox(days, 'Hari'),
        gap,
        titikDua,
        gap,
        timeBox(hours, 'Jam'),
        gap,
        titikDua,
        gap,
        timeBox(minutes, 'Menit'),
        gap,
        titikDua,
        gap,
        timeBox(seconds, 'Detik'),
      ],
    );
  }

  Widget timeBox(int value, String label) {
    return Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                '$value',
                style: const TextStyle(
                  fontSize: 65,
                ),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
