import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/add_coin_view.dart';

class ActionButton extends StatelessWidget {
  final int _selectedIndex;

  const ActionButton(this._selectedIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        _selectedIndex == 2 ? 'Take Photo' : 'Add Coin',
        style: const TextStyle(
          fontSize: ViewConstants.fontMedium,
          color: Colors.white,
        ),
      ),
      isExtended: true,
      icon: Icon(_selectedIndex == 2 ? Icons.camera : Icons.add,
          color: Colors.white, size: 30),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddCoinView(
              addToWantlist: _selectedIndex == 1,
              edit: false,
            ),
          ),
        );
      },
    );
  }
}
