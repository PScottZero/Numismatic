import 'package:flutter/material.dart';
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
        return <PopupMenuItem<SortMethod>>[
              PopupMenuItem(
                child: Text('Sort by...'),
                enabled: false,
              ),
            ] +
            SortMethod.values
                .map((e) => PopupMenuItem(
                      child: Text(e.string()),
                      value: e,
                    ))
                .toList();
      },
    );
  }
}
