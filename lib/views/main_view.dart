import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/components/action_button.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/components/navigation_bar.dart';
import 'package:numismatic/components/search_bar.dart';
import 'package:numismatic/components/sort_menu.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_comparator.dart';
import 'package:provider/provider.dart';

import 'camera_view.dart';
import 'coin_grid_view.dart';

class MainView extends StatefulWidget {
  final CameraDescription? _camera;

  const MainView(this._camera, {Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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

  _MainViewState() : _pageController = PageController();

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
        return CustomScaffold(
          appBarTitle: 'Numismatic',
          appBarActions: [
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
          appBarBottom: PreferredSize(
            preferredSize: ViewConstants.searchBarPreferredSize,
            child: SearchBar(viewingWantlist),
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
