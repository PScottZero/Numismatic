import 'package:flutter/material.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';

class DeleteCoinDialog extends StatelessWidget {
  final CoinCollectionModel model;
  final Coin coin;

  const DeleteCoinDialog(this.model, this.coin);

  @override
  Widget build(BuildContext context) {
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
              fontSize: 18,
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
              fontSize: 18,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
