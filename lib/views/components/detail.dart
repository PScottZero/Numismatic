import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String name;
  final String? value;

  Detail(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return value != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('$name: $value'),
            ],
          )
        : Container();
  }
}
