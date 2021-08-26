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
                    color: (MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white),
                  ),
                  children: [
                    TextSpan(
                      text: value,
                      style: TextStyle(
                        color: this.color ??
                            (MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
