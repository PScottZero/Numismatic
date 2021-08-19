import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  final String name;
  final Either<String?, Future<String?>?> value;
  final Color? color;

  const Detail({
    required this.name,
    required this.value,
    this.color,
  });

  @override
  _DetailState createState() => _DetailState(
        name: name,
        value: value,
        color: color,
      );
}

class _DetailState extends State<Detail> {
  final String name;
  final Either<String?, Future<String?>?> value;
  final Color? color;
  dynamic _detailValue;

  _DetailState({
    required this.name,
    required this.value,
    this.color,
  }) {
    if (value.isRight()) {
      value.getOrElse(() => null)!.then(
            (value) => setState(() => _detailValue = value),
          );
    } else {
      _detailValue = value.foldLeft(0, (previous, r) => r);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _detailValue != null
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
                            text: _detailValue,
                            style: TextStyle(color: this.color),
                          )
                        : TextSpan(text: _detailValue)
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
