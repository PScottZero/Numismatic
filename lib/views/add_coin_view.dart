import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/model/grades.dart';
import 'package:numismatic/scraper/greysheet-scraper.dart';
import 'package:numismatic/views/components/autocomplete_input.dart';
import 'package:numismatic/views/components/coin_data_text_field.dart';
import 'package:numismatic/views/components/multi_source_field.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

class AddCoinView extends StatefulWidget {
  final Coin? coin;
  final bool addToWantlist;
  final bool edit;
  final int coinIndex;

  AddCoinView({
    required this.addToWantlist,
    required this.edit,
    this.coin,
    this.coinIndex = -1,
  });

  @override
  _AddCoinViewState createState() => _AddCoinViewState(
        coin ?? Coin(inCollection: !addToWantlist),
        addToWantlist,
        edit,
        coinIndex,
      );
}

class _AddCoinViewState extends State<AddCoinView> {
  Coin coin;
  final bool addToWantlist;
  final bool edit;
  final int coinIndex;
  CoinCollectionModel? model;

  List<String> _variations = [];

  _AddCoinViewState(this.coin, this.addToWantlist, this.edit, this.coinIndex) {
    if (edit) {
      coin = Coin.copyOf(coin);
    }
  }

  getImageUrls(
    CoinCollectionModel model,
    String? manualType,
    String? manualGrade,
  ) {
    var photogradeType = manualType ??
        CoinType.coinTypeFromString(coin.type)?.photogradeName ??
        '';
    var grade = manualGrade ?? gradeToNumber(coin.grade!);
    return [
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeType-${grade}o.jpg',
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeType-${grade}r.jpg',
    ];
  }

  String? nullIfEmpty(String? str) {
    return str != '' ? str : null;
  }

  handleDataSource(DataSource? source, AsyncCallback onAuto) async {
    if (source == DataSource.auto) {
      return await onAuto();
    } else if (source == DataSource.none) {
      return null;
    }
  }

  addCoin(CoinCollectionModel model) async {
    if (coin.type != '') {
      if (coin.variation != null) {
        await handleDataSource(
          coin.mintageSource,
          () async => coin.mintage = model
                  .greysheetStaticData![CoinType.coinTypeFromString(coin.type)
                          ?.getGreysheetName() ??
                      coin.type]?[coin.variation]
                  ?.mintage ??
              null,
        );
        await handleDataSource(
          coin.retailPriceSource,
          () async {
            coin.retailPrice = await GreysheetScraper.retailPriceForCoin(coin);
            coin.retailPriceLastUpdated = DateTime.now();
          },
        );
      }
      coin.images = getImageUrls(
        model,
        coin.photogradeName,
        coin.photogradeGrade,
      );
      if (edit && coinIndex >= 0) {
        model.overwriteCoin(coinIndex, coin);
        model.refresh();
      } else {
        coin.dateAdded = DateTime.now();
        model.addCoin(coin);
      }
      Navigator.of(context).pop();
    }
  }

  static String gradeToNumber(String grade) {
    var gradeSplit = grade.split('-');
    if (gradeSplit.length > 1) {
      return gradeSplit[1];
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        this.model = model;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${edit ? 'Edit' : 'Add'} Coin',
              style: GoogleFonts.comfortaa(),
            ),
          ),
          body: ListView(
            padding: ViewConstants.paddingAllLarge(),
            children: [
              AutocompleteInput(
                label: 'Coin Type',
                initialValue: coin.type,
                options: model.allCoinTypes,
                onChanged: (type) {
                  setState(() {
                    coin.type = type;
                    _variations = model.greysheetStaticData?[coin.typeId]?.keys
                            .toList() ??
                        [];
                  });
                },
                required: true,
              ),
              AutocompleteInput(
                label: 'Variation',
                initialValue: coin.variation ?? '',
                options: _variations,
                onChanged: (variation) {
                  coin.variation = nullIfEmpty(variation);
                  var yearAndMintMark =
                      HelperFunctions.yearAndMintMarkFromVariation(variation);
                  coin.year = nullIfEmpty(yearAndMintMark?.item1);
                  coin.mintMark = nullIfEmpty(yearAndMintMark?.item2);
                },
                required: true,
              ),
              AutocompleteInput(
                label: 'Grade',
                initialValue: coin.grade ?? '',
                options: grades,
                onChanged: (grade) {
                  coin.grade = nullIfEmpty(grade);
                },
              ),
              MultiSourceField(
                label: 'Mintage',
                initialValueManual: coin.mintage ?? '',
                initialDataSource: coin.mintageSource,
                onChanged: (mintage) => coin.mintage = mintage,
                onRadioChanged: (source) =>
                    coin.mintageSource = source ?? DataSource.auto,
              ),
              MultiSourceField(
                label: 'Retail Price',
                initialValueManual: coin.retailPrice ?? '',
                initialDataSource: coin.retailPriceSource,
                onChanged: (price) => coin.retailPrice = price,
                onRadioChanged: (source) =>
                    coin.retailPriceSource = source ?? DataSource.auto,
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Advanced',
                  style: TextStyle(
                    fontSize: ViewConstants.fontMedium,
                  ),
                ),
                children: [
                  CoinDataTextField(
                    label: 'Photograde Name Override',
                    onChanged: (name) =>
                        coin.photogradeName = nullIfEmpty(name),
                  ),
                  CoinDataTextField(
                    label: 'Photograde Grade Override',
                    onChanged: (grade) =>
                        coin.photogradeGrade = nullIfEmpty(grade),
                  ),
                ],
              ),
              RoundedButton(
                label: edit ? 'Save Changes' : 'Add Coin',
                onPressed: () => addCoin(model),
              )
            ],
          ),
        );
      },
    );
  }
}
