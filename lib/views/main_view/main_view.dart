import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/my_scaffold.dart';
import '../../model/app_model.dart';
import '../../services/coin_comparator.dart';
import '../coin_grid_view/coin_grid_view.dart';
import '../settings_view/settings_view.dart';
import 'components/my_floating_action_button.dart';
import 'components/my_search_bar.dart';
import 'components/sort_menu.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _views = [
    const CoinGridView(),
    const CoinGridView(isWantlist: true),
    const SettingsView(),
  ];

  final List<Widget> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.grid_view_rounded),
      label: 'Collection',
    ),
    const NavigationDestination(
      icon: Icon(Icons.favorite),
      label: 'Wantlist',
    ),
    const NavigationDestination(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        return MyScaffold(
          hasAppBar: _selectedIndex < 2,
          appBarTitle: 'NumisLog',
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
            child: MySearchBar(_selectedIndex == 1),
          ),
          body: _views[_selectedIndex],
          floatingActionButton: _selectedIndex != 2
              ? MyFloatingActionButton(_selectedIndex == 1)
              : null,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            destinations: _destinations,
          ),
        );
      },
    );
  }
}
