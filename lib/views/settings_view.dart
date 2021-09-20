import 'package:flutter/material.dart';
import 'package:numismatic/components/confirm_cancel_dialog.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  CoinCollectionModel? _model;

  _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Backup Coins',
          message: 'Are you sure you want to backup your coin data? '
              'Existing backup data will be lost.',
          confirmAction: 'Backup',
          onConfirmed: () {
            _model?.backupCoins(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Restore Coins',
          message: 'Are you sure you want to restore your coin data? '
              'Existing coin data will be lost.',
          confirmAction: 'Restore',
          onConfirmed: () {
            _model?.restoreCoins(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return Container(
          padding: ViewConstants.paddingAllLarge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                label: 'Backup Coins',
                onPressed: _showBackupDialog,
              ),
              RoundedButton(
                label: 'Restore Coins',
                color: ViewConstants.colorWarning,
                textColor: ViewConstants.colorWarningAccent,
                onPressed: _showRestoreDialog,
              ),
            ],
          ),
        );
      },
    );
  }
}
