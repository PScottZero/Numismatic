import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_comparator.dart';
import 'package:numismatic/model/sort_method.dart';

class SortMenu extends StatelessWidget {
  final Function(SortMethod) setSortMethod;

  const SortMenu(this.setSortMethod);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortMethod>(
      icon: Icon(Icons.sort),
      onSelected: setSortMethod,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Sort by...'),
            enabled: false,
          ),
          PopupMenuItem(
            child: Text('Type'),
            value: SortMethod.type,
          ),
          PopupMenuItem(
            child: Text('Year'),
            value: SortMethod.year,
          ),
          PopupMenuItem(
            child: Text('Retail Price'),
            value: SortMethod.retailPrice,
          ),
        ];
      },
    );
  }
}
