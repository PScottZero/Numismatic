import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;
  final Color? color;

  const Detail({
    required this.name,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '$name: ',
                  style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(fontSize: 20),
                    height: 1.5,
                  ),
                  children: [
                    color != null
                        ? TextSpan(
                            text: value,
                            style: TextStyle(color: this.color),
                          )
                        : TextSpan(text: value)
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
