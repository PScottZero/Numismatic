import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/action_button.dart';
import 'package:numismatic/views/camera_view.dart';
import 'package:numismatic/views/coin_grid_view.dart';
import 'package:provider/provider.dart';

import 'components/search_bar.dart';
import 'components/sort_menu.dart';
import 'model/coin_collection_model.dart';
import 'model/coin_comparator.dart';
import 'model/navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(),
      child: NumismaticApp(cameras.isNotEmpty ? cameras.first : null),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  final CameraDescription? _camera;

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

  const NumismaticApp(this._camera, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      debugShowCheckedModeBanner: false,
      theme: themeOfBrightness(Brightness.light),
      darkTheme: themeOfBrightness(Brightness.dark),
      home: Navigation(_camera),
    );
  }
}

class Navigation extends StatefulWidget {
  final CameraDescription? _camera;

  const Navigation(this._camera, {Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final PageController _pageController;
  var _selectedIndex = 0;

  List<Widget> get _options => [
        const CoinGridView(),
        const CoinGridView(isWantlist: true),
        widget._camera != null
            ? CameraView(camera: widget._camera!)
            : Container(),
      ];

  bool get viewingCollection => _selectedIndex == 0;
  bool get viewingWantlist => _selectedIndex == 1;
  bool get viewingCamera => _selectedIndex == 2;

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
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onTap: _onTap,
            cameraIsInitialized: widget._camera != null,
          ),
          floatingActionButton: ActionButton(_selectedIndex),
        );
      },
    );
  }
}
