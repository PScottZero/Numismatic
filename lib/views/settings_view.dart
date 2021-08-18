import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  final buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.all(16),
    ),
  );

  final textStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {},
          child: Text(
            'Export Collection JSON',
            style: textStyle,
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Import Collection JSON',
              style: textStyle,
            ),
          ),
        ),
      ],
    );
  }
}
