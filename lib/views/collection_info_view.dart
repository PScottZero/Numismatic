import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/confirm_cancel_dialog.dart';
import 'package:numismatic/views/components/detail.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

class CollectionInfoView extends StatefulWidget {
  @override
  _CollectionInfoViewState createState() => _CollectionInfoViewState();
}

class _CollectionInfoViewState extends State<CollectionInfoView> {
  CoinCollectionModel? _modelRef;

  String collectionValue(CoinCollectionModel model) {
    if (model.collection.length > 0) {
      var sum = model.collection
          .map(
            (e) => double.tryParse(
              e.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
            ),
          )
          .toList()
          .reduce((sum, element) => (sum ?? 0) + (element ?? 0));
      return '\$${(sum ?? 0.0).toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  _showRestoreDialog() async {
    return showDialog(
      context: context,
      builder: (context) => ConfirmCancelDialog(
        title: 'Restore App',
        message: 'Are you sure you want to restore from a previous backup?',
        confirmAction: 'Restore',
        onConfirmed: () {
          _modelRef?.loadCollectionJson().then(
            (success) {
              var message = 'Successfully restored app';
              if (!success) {
                message = 'Could not find app backup';
              }
              _modelRef?.notify(message, context);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  _backup() async {
    await _modelRef?.saveCollectionJson();
    _modelRef?.notify('Successfully backed up app', context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _modelRef = model;
        return Container(
          padding: ViewConstants.paddingAllLarge(),
          child: Center(
            child: ListView(
              children: [
                Text(
                  'Collection Info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ViewConstants.fontLarge,
                    fontWeight: FontWeight.bold,
                    height: ViewConstants.spacing1_5,
                  ),
                ),
                Detail(
                  name: 'Coins In Collection',
                  value: model.collection.length.toString(),
                ),
                Detail(
                  name: 'Coins In Wantlist',
                  value: model.wantlist.length.toString(),
                ),
                Detail(
                  name: 'Collection Value',
                  value: collectionValue(model),
                ),
                RoundedButton(
                  label: 'Backup App Data',
                  onPressed: _backup,
                ),
                RoundedButton(
                  label: 'Restore App Data',
                  color: ViewConstants.colorWarning,
                  onPressed: _showRestoreDialog,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
