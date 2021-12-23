import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/add_coin_view/add_coin_view.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final int _selectedIndex;

  const CustomFloatingActionButton(this._selectedIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FittedBox(
        child: FloatingActionButton.extended(
          label: Text(
            _selectedIndex == 2 ? 'Take Photo' : 'Add Coin',
            style: TextStyle(
              fontSize: ViewConstants.mediumFont,
              color: ViewConstants.accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          isExtended: true,
          icon: Icon(
            _selectedIndex == 2 ? Icons.camera : Icons.add,
            color: ViewConstants.accentColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: ViewConstants.mediumBorderRadius,
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
        ),
      ),
    );
  }
}
