import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/add_coin_view.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final int _selectedIndex;

  const CustomFloatingActionButton(this._selectedIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        _selectedIndex == 2 ? 'Take Photo' : 'Add Coin',
        style: const TextStyle(
          fontSize: ViewConstants.fontSmall,
          color: ViewConstants.colorAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      isExtended: true,
      icon: Icon(
        _selectedIndex == 2 ? Icons.camera : Icons.add,
        color: ViewConstants.colorAccent,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: ViewConstants.borderRadiusMedium,
      ),
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
