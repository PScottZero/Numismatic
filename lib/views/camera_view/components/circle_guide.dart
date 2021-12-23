import 'package:flutter/material.dart';

class CircleGuide extends StatelessWidget {
  const CircleGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      height: MediaQuery.of(context).size.width - 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width - 120,
        ),
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }
}
