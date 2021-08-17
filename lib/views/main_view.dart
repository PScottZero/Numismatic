import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/views/settings_view.dart';

import 'coin_grid_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    CoinGridView(),
    Center(child: Text('Camera')),
    SettingsView(),
  ];
  List<String> _menuOptions = ['Export Collection', 'Import Collection'];
  late PageController _pageController;

  void _onBottomNavTap(int index) {
    _onPageSwipe(index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  void _onPageSwipe(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return _menuOptions
                  .map((e) => PopupMenuItem<String>(child: Text(e)))
                  .toList();
            },
          )
        ],
        title: Center(
          child: Text(
            'Numismatic',
            style: GoogleFonts.comfortaa(color: Colors.white),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: _onPageSwipe,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        items: [
          BottomNavigationBarItem(
            label: 'collection',
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: 'camera',
            icon: Icon(Icons.camera),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: Icon(Icons.settings),
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
