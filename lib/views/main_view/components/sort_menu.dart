import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/sort_method.dart';
import 'package:numismatic/services/coin_comparator.dart';

class SortMenu extends StatelessWidget {
  final Function(SortMethod) setSortMethod;

  const SortMenu(this.setSortMethod, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortMethod>(
      icon: const Icon(Icons.sort),
      onSelected: setSortMethod,
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.mediumBorderRadius,
      ),
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? Colors.white
          : ViewConstants.backgroundAccentColorFromContext(context),
      itemBuilder: (context) {
        return <PopupMenuItem<SortMethod>>[
              const PopupMenuItem(
                child: Text('Sort by...'),
                enabled: false,
              ),
            ] +
            SortMethod.values
                .map(
                  (e) => PopupMenuItem(
                    child: Text(
                      e.string(),
                      style: TextStyle(
                        color: CoinComparator.sortMethod == e
                            ? ViewConstants.accentColor
                            : null,
                      ),
                    ),
                    value: e,
                  ),
                )
                .toList();
      },
    );
  }
}
