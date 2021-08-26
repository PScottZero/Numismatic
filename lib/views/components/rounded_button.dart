import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color? color;

  RoundedButton({required this.label, required this.onPressed, this.color});

  MaterialStateProperty<T> msp<T>(T property) =>
      MaterialStateProperty.all<T>(property);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: msp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: msp(color),
          padding: msp(EdgeInsets.only(top: 15, bottom: 15)),
          textStyle: msp(GoogleFonts.comfortaa(fontSize: 20)),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
