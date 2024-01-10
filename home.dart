import 'package:login/pages/home/discover.dart';
import 'package:login/pages/home/profile.dart';
import 'package:login/pages/home/shipments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _aktifIcerik = 1;
  List _icerikler = [];

  @override
  void initState() {
    super.initState();
    _icerikler = [
      DiscoverScreen(),
      ShipmentScreen(),
      ProfileScreen(
        username: widget.username,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "LOGIN",
              style: GoogleFonts.bebasNeue(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(247, 80, 80, 1.0),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.android,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
        shadowColor: Colors.blueGrey[200],
        backgroundColor: Colors.blueGrey[100],
        elevation: 3.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _icerikler.isNotEmpty ? _icerikler[_aktifIcerik] : Container(),
      bottomNavigationBar: BottomNavigationBarMethod(),
    );
  }

  BottomNavigationBar BottomNavigationBarMethod() {
    return BottomNavigationBar(
      currentIndex: _aktifIcerik,
      items: [
        ItemIcons(Icons.zoom_in_sharp, "Keşfet"),
        ItemIcons(Icons.home_outlined, "Ana Sayfa"),
        ItemIcons(Icons.account_circle_rounded, "Profil"),
      ],
      onTap: (value) {
        setState(() {
          _aktifIcerik = value;
        });
      },
      selectedItemColor: Color.fromRGBO(243, 53, 53, 1),
      unselectedItemColor: Color.fromARGB(255, 17, 70, 99),
      selectedLabelStyle:
          GoogleFonts.bebasNeue(fontSize: 20.0, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          GoogleFonts.bebasNeue(fontSize: 15.0, fontWeight: FontWeight.w200),
      backgroundColor: Colors.blueGrey[100],
    );
  }

  BottomNavigationBarItem ItemIcons(icon, label) => BottomNavigationBarItem(
        icon: Icon(
          icon,
          size: 32.0,
        ),
        label: label,
      );
}
