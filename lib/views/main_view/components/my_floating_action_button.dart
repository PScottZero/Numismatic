import 'package:flutter/material.dart';

import '../../../constants/view_constants.dart';
import '../../add_coin_view/add_coin_view.dart';

class MyFloatingActionButton extends StatelessWidget {
  final bool addToWantlist;

  const MyFloatingActionButton(this.addToWantlist, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text(
        'Add Coin',
        style: TextStyle(
          fontSize: ViewConstants.mediumFont,
        ),
      ),
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddCoinView(
              addToWantlist: addToWantlist,
              edit: false,
            ),
          ),
        );
      },
    );
  }
}
