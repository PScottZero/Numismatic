import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/views/main_view/components/custom_floating_action_button.dart';
import 'package:numismatic/views/main_view/components/you_navigation_bar.dart';
import 'package:numismatic/views/main_view/components/search_bar.dart';
import 'package:numismatic/views/main_view/components/sort_menu.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/app_model.dart';
import 'package:numismatic/services/coin_comparator.dart';
import 'package:numismatic/views/settings_view/settings_view.dart';
import 'package:provider/provider.dart';

import '../camera_view/camera_view.dart';
import '../coin_grid_view/coin_grid_view.dart';

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

  bool _showFloatingActionButton() => _selectedIndex < 2;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            ViewConstants.backgroundAccentColorFromContext(context),
        systemNavigationBarIconBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? ViewConstants.backgroundColorFromContext(context)
                : Colors.white,
        statusBarIconBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
    return Consumer<AppModel>(
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
              padding: const EdgeInsets.only(right: 10),
              child: SortMenu(model.setSortMethod),
            ),
          ],
          appBarBottom: PreferredSize(
            preferredSize: const Size(double.infinity, 70),
            child: SearchBar(viewingWantlist),
          ),
          appBarColor: Colors.transparent,
          body: _options[_selectedIndex],
          bottomNavigationBar: YouNavigationBar(
            selectedIndex: _selectedIndex,
            onTap: _onTap,
            cameraIsInitialized: widget._camera != null,
          ),
          floatingActionButton: _showFloatingActionButton()
              ? CustomFloatingActionButton(_selectedIndex)
              : null,
        );
      },
    );
  }
}
