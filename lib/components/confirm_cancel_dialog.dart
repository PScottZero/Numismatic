import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class ConfirmCancelDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmAction;
  final VoidCallback onConfirmed;

  const ConfirmCancelDialog({
    required this.title,
    required this.message,
    required this.confirmAction,
    required this.onConfirmed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ViewConstants.backgroundAccentColorFromContext(context),
      title: Text(title),
      content: Text(
        message,
        style: const TextStyle(height: 2),
      ),
      actions: [
        TextButton(
          onPressed: onConfirmed,
          child: Text(
            confirmAction,
            style: TextStyle(
              fontSize: ViewConstants.mediumFont,
              color: ViewConstants.warningColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: ViewConstants.mediumFont,
              color: ViewConstants.accentColor,
            ),
          ),
        ),
      ],
    );
  }
}
