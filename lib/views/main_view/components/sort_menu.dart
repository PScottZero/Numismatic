import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/sort_method.dart';

class SortMenu extends StatelessWidget {
  final Function(SortMethod) setSortMethod;

  const SortMenu(this.setSortMethod, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortMethod>(
      onSelected: setSortMethod,
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.mediumBorderRadius,
      ),
      itemBuilder: (context) {
        return <PopupMenuItem<SortMethod>>[
              const PopupMenuItem(
                enabled: false,
                child: Text(
                  'Sort by...',
                  style: TextStyle(
                    fontSize: ViewConstants.mediumFont,
                  ),
                ),
              ),
            ] +
            SortMethod.values
                .map(
                  (method) => PopupMenuItem(
                    value: method,
                    child: Text(
                      method.string(),
                      style: const TextStyle(
                        fontSize: ViewConstants.mediumFont,
                      ),
                    ),
                  ),
                )
                .toList();
      },
    );
  }
}
