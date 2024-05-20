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
  double heightHeader = 68.0;
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
      height: heightHeader,
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
    if ((index == 1 || index == 2) &&
        !Provider.of<HeaderState>(context, listen: false).login) {
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
    if (Provider.of<HeaderState>(context, listen: false).login) {
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
                    Provider.of<HeaderState>(context, listen: false)
                        .logoutAccount();
                    Provider.of<HeaderState>(context, listen: false)
                        .setIndex(0);
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

    if (Provider.of<HeaderState>(context, listen: false).selectedIndex == 4) {
      return SizedBox(
        height: 40,
        width: 218,
        child: FilledButton(
          onPressed: () {
            setState(() {
              Provider.of<HeaderState>(context, listen: false).setIndex(5);
            });
          },
          child: const Text('Daftar'),
        ),
      );
    }

    if (Provider.of<HeaderState>(context, listen: false).selectedIndex == 5) {
      return SizedBox(
        height: 40,
        width: 218,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              Provider.of<HeaderState>(context, listen: false).setIndex(4);
            });
          },
          child: const Text('Masuk'),
        ),
      );
    }
    return Row(
      children: [
        FilledButton(
          onPressed: () {
            setState(() {
              Provider.of<HeaderState>(context, listen: false).setIndex(4);
            });
          },
          child: const Text('Masuk'),
        ),
        const SizedBox(width: 24.0),
        OutlinedButton(
          onPressed: () {
            setState(() {
              Provider.of<HeaderState>(context, listen: false).setIndex(5);
            });
          },
          child: const Text('Daftar'),
        ),
      ],
    );
  }
}
