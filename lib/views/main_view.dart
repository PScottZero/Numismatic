import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/components/custom_floating_action_button.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/components/navigation_bar.dart';
import 'package:numismatic/components/search_bar.dart';
import 'package:numismatic/components/sort_menu.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_comparator.dart';
import 'package:numismatic/views/settings_view.dart';
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
  var _selectedIndex = 0;

  List<Widget> get _options {
    var options = <Widget>[
      const CoinGridView(),
      const CoinGridView(isWantlist: true),
    ];
    if (widget._camera != null) {
      options.add(CameraView(camera: widget._camera!));
    }
    options.add(const SettingsView());
    return options;
  }

  bool get viewingCollection => _selectedIndex == 0;
  bool get viewingWantlist => _selectedIndex == 1;
  bool get viewingCamera => _selectedIndex == 2;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _onLastPage() =>
      (_options.length == 3 && _selectedIndex != 2) ||
      (_options.length == 4 && _selectedIndex != 3);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ViewConstants.colorBackgroundAccent(context),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return CustomScaffold(
          hasAppBar: _selectedIndex < 2,
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
          appBarColor: Colors.transparent,
          body: _options[_selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onTap: _onTap,
            cameraIsInitialized: widget._camera != null,
          ),
          floatingActionButton:
              _onLastPage() ? CustomFloatingActionButton(_selectedIndex) : null,
        );
      },
    );
  }
}
