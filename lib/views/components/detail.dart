import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;
  final Color color;

  Detail(this.name, this.value, {this.color = Colors.white});

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
                    TextSpan(text: value, style: TextStyle(color: this.color))
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
