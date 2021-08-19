import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;
  final String? altValue;
  final Color? color;

  Detail(this.name, this.value, {this.altValue, this.color});

  String? get detailValue {
    if (altValue != null) {
      return altValue;
    } else {
      return value;
    }
  }

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
                            text: detailValue,
                            style: TextStyle(color: this.color),
                          )
                        : TextSpan(text: detailValue)
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
