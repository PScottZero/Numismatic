import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:numismatic/views/coin_grid_view.dart';
import 'package:provider/provider.dart';

import 'components/search_bar.dart';
import 'components/sort_menu.dart';
import 'model/coin_collection_model.dart';
import 'model/coin_comparator.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(),
      child: const NumismaticApp(),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  ThemeData themeOfBrightness(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ViewConstants.colorPrimarySwatch,
        ).copyWith(
          secondary: ViewConstants.colorPrimary,
          brightness: brightness,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(
          const TextTheme(
            bodyText2: TextStyle(
              fontSize: ViewConstants.fontMedium,
              height: ViewConstants.spacing1_5,
            ),
          ),
        ),
      );

  const NumismaticApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      debugShowCheckedModeBanner: false,
      theme: themeOfBrightness(Brightness.light),
      darkTheme: themeOfBrightness(Brightness.dark),
      home: const Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final PageController _pageController;
  final _options = <Widget>[
    const CoinGridView(),
    const CoinGridView(isWantlist: true),
  ];
  var _selectedIndex = 0;

  bool get viewingWantlist => _selectedIndex == 1;

  _NavigationState() : _pageController = PageController();

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ViewConstants.colorPrimary,
            foregroundColor: Colors.white,
            title: Padding(
              padding: ViewConstants.paddingLeftSmall,
              child: Text(
                'Numismatic',
                style: GoogleFonts.quicksand(
                  fontSize: ViewConstants.fontMedium,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: model.toggleSortDirection,
                icon: Icon(
                  CoinComparator.ascending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                ),
              ),
              Padding(
                padding: ViewConstants.paddingRightLarge,
                child: SortMenu(model.setSortMethod),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: ViewConstants.searchBarPreferredSize,
              child: SearchBar(viewingWantlist),
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
            selectedItemColor: ViewConstants.colorPrimary,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view,
                ),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  viewingWantlist ? Icons.favorite : Icons.favorite_border,
                ),
                label: 'Wantlist',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text(
              'Add Coin',
              style: TextStyle(
                fontSize: ViewConstants.fontMedium,
                color: Colors.white,
              ),
            ),
            isExtended: true,
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCoinView(
                    addToWantlist: viewingWantlist,
                    edit: false,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
