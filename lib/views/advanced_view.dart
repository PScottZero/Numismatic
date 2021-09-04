import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/confirm_cancel_dialog.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

class AdvancedView extends StatefulWidget {
  @override
  _AdvancedViewState createState() => _AdvancedViewState();
}

class _AdvancedViewState extends State<AdvancedView> {
  CoinCollectionModel? _modelRef;

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
            child: Column(
              children: [
                RoundedButton(
                  label: 'Backup App Data',
                  onPressed: _backup,
                  topMargin: false,
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
