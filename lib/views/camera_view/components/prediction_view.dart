import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';

import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/services/coin_data_retriever.dart';

class PredictionView extends StatefulWidget {
  final String prediction;

  const PredictionView(this.prediction, {Key? key}) : super(key: key);

  @override
  _PredictionViewState createState() => _PredictionViewState();
}

class _PredictionViewState extends State<PredictionView> {
  Map<String, List<String>> images = {};
  List<CoinType> types = [];

  @override
  void initState() {
    super.initState();
    for (var type in CoinType.coinTypes) {
      if (type.classifierLabel == widget.prediction) {
        types.add(type);
      }
    }
    loadImages();
  }

  void loadImages() async {
    for (var type in types) {
      var coin = Coin.empty();
      coin.type.value = type.name;
      coin.grade.value = '64';
      coin.imagesSource = DataSource.auto;
      await CoinDataRetriever.setImages(coin, null);
      images[type.name] = coin.images!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 40) / 2;
    return ListView(
      children: <Widget>[
            const SizedBox(
              height: ViewConstants.gapSmall,
            )
          ] +
          types
              .map(
                (type) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Text(
                        type.name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: width * 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (images[type.name] ?? [])
                              .map(
                                (e) => Image.memory(
                                  base64Decode(e),
                                  width: width,
                                  height: width,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: ViewConstants.gapLarge,
                    )
                  ],
                ),
              )
              .toList(),
    );
  }
}
