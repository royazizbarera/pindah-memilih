import 'package:flutter/material.dart';
import 'package:pindah_memilih/constants.dart';

class Header extends StatefulWidget {
  final int selectedItem;

  const Header({super.key, required this.selectedItem});

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
    return SizedBox(
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
    switch (index) {
      case 0:
        return () {};
      case 1:
        if (!isLogin) {
          return null;
        }
      case 2:
        if (!isLogin) {
          return null;
        }

      case 3:
        return () {};
      default:
        return null;
    }
    return null;
  }

  // Menu
  Widget menu() {
    return Row(
      children: [
        for (int item = 0; item < menuItems.length; item++) ...[
          item == widget.selectedItem
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
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Keluar'),
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

class MenuState extends ChangeNotifier {
  int _activeMenu = 0;

  int get activeMenu => _activeMenu;

  void updateMenu(int index) {
    _activeMenu = index;
    notifyListeners();
  }

  onPressedMenu(context, int index, bool isLogin) {
    switch (index) {
      case 0:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Beranda()),
        );
      case 1:
        if (!isLogin) {
          return null;
        }
      case 2:
        if (!isLogin) {
          return null;
        }

      case 3:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Beranda()),
        );
      default:
    }
  }
}

class Beranda extends StatelessWidget {
  const Beranda({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
