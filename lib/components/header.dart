import 'package:flutter/material.dart';
import 'package:pindah_memilih/components/header_state.dart';
import 'package:pindah_memilih/constants.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  double heightHeader = 64.0;
  bool isLogin = true;
  String username = 'Roy Aziz Barera';
  List<String> menuItems = [
    'Beranda',
    'Pengajuan',
    'Status Pengajuan',
    'Informasi Pengajuan',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      height: heightHeader,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mainPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo(),
            Row(
              children: [
                menu(),
                divider(),
                rightHeader(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Row(
      children: [
        VerticalDivider(),
        SizedBox(width: 24.0),
      ],
    );
  }

  Widget logo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 6.0,
      ),
      child: Image.asset('assets/images/logo-pindah-memilih.png'),
    );
  }

  Function()? _onPressedMenu(index) {
    if ((index == 1 || index == 2) && !isLogin) {
      return null;
    }
    return () {
      Provider.of<HeaderState>(context, listen: false).setIndex(index);
    };
  }

  // Menu
  Widget menu() {
    int selectedItem = Provider.of<HeaderState>(context).selectedIndex;
    return Row(
      children: [
        for (int item = 0; item < menuItems.length; item++) ...[
          item == selectedItem
              ? FilledButton.tonal(
                  onPressed: _onPressedMenu(item),
                  child: Text(menuItems[item]),
                )
              : TextButton(
                  onPressed: _onPressedMenu(item),
                  child: Text(menuItems[item]),
                ),
          const SizedBox(width: 24.0)
        ],
      ],
    );
  }

  // right header
  Widget rightHeader() {
    int? selectedItem;
    if (isLogin) {
      return Row(
        children: [
          PopupMenuButton<int>(
            initialValue: selectedItem,
            offset: const Offset(0, 34),
            onSelected: (int item) {
              setState(() {
                selectedItem = item;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8.0),
                    Text(
                      username,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Profil'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: const Text('Keluar'),
                onTap: () {
                  setState(() {
                    isLogin = false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(width: 24.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          )
        ],
      );
    }
    return Row(
      children: [
        FilledButton(
          onPressed: () {
            setState(() {
              isLogin = true;
            });
          },
          child: const Text('Masuk'),
        ),
        const SizedBox(width: 24.0),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Daftar'),
        ),
      ],
    );
  }
}
