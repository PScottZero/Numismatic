import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

class DeleteCoinDialog extends StatelessWidget {
  final Coin coin;

  const DeleteCoinDialog(this.coin);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return AlertDialog(
          title: Text('Delete Coin'),
          content: Text(
            'Are you sure you want to delete this coin?',
            style: TextStyle(height: 2),
          ),
          actions: [
            TextButton(
              onPressed: () {
                model.deleteCoin(coin);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: ViewConstants.fontSmall,
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: ViewConstants.fontSmall,
                  color: Colors.blue[300],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
