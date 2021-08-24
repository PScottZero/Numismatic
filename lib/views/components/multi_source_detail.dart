import 'package:flutter/cupertino.dart';
import 'package:numismatic/model/multi-source-value.dart';

import 'detail.dart';

class MultiSourceDetail<T> extends StatelessWidget {
  final String name;
  final MultiSourceValue? multiSourceValue;
  final T request;

  MultiSourceDetail({
    required this.name,
    required this.multiSourceValue,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return multiSourceValue != null
        ? FutureBuilder<String>(
            future: multiSourceValue!.value(request),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Detail(name: name, value: snapshot.data);
              } else {
                return Container();
              }
            },
          )
        : Container();
  }
}
