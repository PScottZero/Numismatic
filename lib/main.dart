import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/coin_grid_view.dart';
import 'package:numismatic/views/collection_info_view.dart';
import 'package:provider/provider.dart';

import 'model/coin_collection_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(),
      child: NumismaticApp(),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  ThemeData themeOfBrightness(Brightness brightness) => ThemeData(
        brightness: brightness,
        primarySwatch: Colors.blue,
        primaryColor: ViewConstants.primaryColor,
        accentColor: ViewConstants.primaryColor,
        textTheme: GoogleFonts.comfortaaTextTheme(
          TextTheme(
            bodyText2: TextStyle(
              fontSize: ViewConstants.fontMedium,
              height: ViewConstants.lineHeight,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      theme: themeOfBrightness(Brightness.light),
      darkTheme: themeOfBrightness(Brightness.dark),
      home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late PageController _pageController;
  var _selectedIndex = 0;
  final _options = <Widget>[
    CoinGridView(),
    CoinGridView(isWantlist: true),
    CollectionInfoView(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
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
        centerTitle: true,
        title: Text(
          'Numismatic',
          style: GoogleFonts.comfortaa(),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _options,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wantlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
