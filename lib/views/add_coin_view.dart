import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/views/components/autocomplete_input.dart';
import 'package:numismatic/views/components/data_input.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

class AddCoinView extends StatefulWidget {
  final bool addToWantlist;

  const AddCoinView(this.addToWantlist);

  @override
  _AddCoinViewState createState() => _AddCoinViewState(addToWantlist);
}

class _AddCoinViewState extends State<AddCoinView> {
  final Coin coin = Coin();
  final bool addToWantlist;

  _AddCoinViewState(this.addToWantlist) {
    coin.inCollection = !addToWantlist;
  }

  String stringToGreysheetType(String type, List<CoinType> coinTypes) {
    String greysheetType = type;
    coinTypes.forEach(
      (coinType) {
        if (coinType.name == type || coinType.greysheetName == type) {
          greysheetType = coinType.getGreysheetName();
        }
      },
    );
    return greysheetType;
  }

  List<String?> yearAndMintMarkFromVariation(String variation) {
    String? year;
    String? mintMark;
    if (variation.length > 0) {
      try {
        year = variation.split(' ')[0];
        if (year.contains('-')) {
          var split = year.split('-');
          year = split[0];
          mintMark = split[1];
        }
      } catch (_) {}
    }
    return [year, mintMark];
  }

  getImageUrls(
    CoinCollectionModel model,
    String? manualType,
    String? manualGrade,
  ) {
    var photogradeType = manualType ??
        CoinType.coinTypeFromString(coin.type, model.coinTypes)
            ?.photogradeName ??
        '';
    var grade = manualGrade ?? CoinCollectionModel.gradeToNumber(coin.grade!);
    return [
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeType-${grade}o.jpg',
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeType-${grade}r.jpg',
    ];
  }

  finalizeCoinData(CoinCollectionModel model) async {
    coin.images = getImageUrls(
      model,
      coin.photogradeName,
      coin.photogradeGrade,
    );
    model.addCoin(coin);
    Navigator.of(context).pop();
  }

  String? nullIfEmpty(String? str) {
    return str != '' ? str : null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Add Coin',
              style: GoogleFonts.comfortaa(),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(30),
            children: [
              AutocompleteInput(
                label: 'Coin Type',
                options: model.allCoinTypes,
                onChanged: (type) {
                  coin.type = type;
                  setState(() {});
                },
                required: true,
              ),
              AutocompleteInput(
                label: 'Variation',
                options: model.variationsFromCoinType(
                  stringToGreysheetType(coin.type, model.coinTypes),
                ),
                onChanged: (variation) {
                  coin.variation = nullIfEmpty(variation);
                  var yearAndMintMark = yearAndMintMarkFromVariation(variation);
                  coin.year = nullIfEmpty(yearAndMintMark[0]);
                  coin.mintMark = nullIfEmpty(yearAndMintMark[1]);
                  setState(() {});
                },
              ),
              AutocompleteInput(
                label: 'Grade',
                options: model.gradeOptions.map((e) => e.item1).toList(),
                onTap: () {
                  if (coin.type.length > 0 && coin.variation != null) {
                    model.getGreysheetGradesForCoin(coin);
                  }
                },
                comparator: (a, b) =>
                    (int.tryParse(CoinCollectionModel.gradeToNumber(b)) ?? 0)
                        .compareTo(
                  (int.tryParse(CoinCollectionModel.gradeToNumber(a)) ?? 0),
                ),
                onChanged: (grade) {
                  coin.grade = nullIfEmpty(grade);
                  model.setCoinPrice(coin, grade);
                },
              ),
              DataInput(
                label: 'Photograde Name Override',
                onChanged: (name) => coin.photogradeName = nullIfEmpty(name),
              ),
              DataInput(
                label: 'Photograde Grade Override',
                onChanged: (grade) => coin.photogradeGrade = nullIfEmpty(grade),
              ),
              SizedBox(height: 10),
              RoundedButton(
                label: 'Add Coin',
                onPressed: () {
                  coin.mintage = model
                          .greysheetStaticData![CoinType.coinTypeFromString(
                                      coin.type, model.coinTypes)
                                  ?.getGreysheetName() ??
                              coin.type]?[coin.variation]
                          ?.mintage ??
                      null;
                  finalizeCoinData(model);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
