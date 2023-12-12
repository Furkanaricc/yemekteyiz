
import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:yemekteyiz/ui/views/anasayfa.dart';
import 'package:yemekteyiz/ui/views/favori_sayfa.dart';
import 'package:yemekteyiz/ui/views/sepet_sayfa.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() => SizedBox.expand(
    child: IndexedStack(
      index: _currentIndex,
      children: const <Widget>[
        Anasayfa(),
        FavoriSayfa(),
        SepetSayfa(),
      ],
    ),
  );

  Widget _bottomNavBar() => BottomNavBar(
    showElevation: true,
    selectedIndex: _currentIndex,
    onItemSelected: (index) {
      setState(() => _currentIndex = index);
    },
    items: <BottomNavBarItem>[
      BottomNavBarItem(
        title: 'Anasayfa',
        icon: const Icon(Icons.home_filled),
        activeColor: Colors.white,
        inactiveColor: Colors.orangeAccent,
        activeBackgroundColor: Colors.orangeAccent,
      ),
      BottomNavBarItem(
        title: 'Favoriler',
        icon: const Icon(Icons.favorite),
        activeColor: Colors.white,
        inactiveColor: Colors.orangeAccent,
        activeBackgroundColor: Colors.orangeAccent,
      ),

      BottomNavBarItem(
        title: 'Sepetim',
        icon: const Icon(Icons.shopping_cart),
        inactiveColor: Colors.orangeAccent,
        activeColor: Colors.white,
        activeBackgroundColor: Colors.orangeAccent,
      ),
    ],
  );
}