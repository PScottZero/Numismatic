import 'package:flutter/material.dart';
import 'package:numislog/components/confirm_cancel_dialog.dart';
import 'package:numislog/components/my_elevated_button.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/app_model.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  AppModel? _model;

  _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Backup Coins',
          message: 'Are you sure you want to backup your coin data? '
              'Existing backup data will be lost.',
          confirmAction: 'Backup',
          onConfirmed: () async {
            var result = await _model?.backupCoins() ?? 'Internal error';
            _snackBar(result);
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
          onConfirmed: () async {
            var result = await _model?.restoreCoins() ?? 'Internal error';
            _snackBar(result);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  _snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: ViewConstants.mediumFont,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        _model = model;
        return Container(
          padding: ViewConstants.largePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyElevatedButton(
                label: 'Backup Coins',
                onPressed: _showBackupDialog,
              ),
              MyElevatedButton(
                label: 'Restore Coins',
                warning: true,
                onPressed: _showRestoreDialog,
              ),
            ],
          ),
        );
      },
    );
  }
}
