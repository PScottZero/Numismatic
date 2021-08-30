import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/scraper/greysheet-scraper.dart';
import 'package:numismatic/views/components/autocomplete_input.dart';
import 'package:numismatic/views/components/coin_data_text_field.dart';
import 'package:numismatic/views/components/multi_source_text_field.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

const List<String> grades = [
  'PR-70',
  'PR-69',
  'PR-68',
  'PR-67',
  'PR-66',
  'PR-65',
  'PR-64',
  'PR-63',
  'PR-62',
  'PR-61',
  'PR-60',
  'MS-70',
  'MS-69',
  'MS-68',
  'MS-67',
  'MS-66',
  'MS-65',
  'MS-64',
  'MS-63',
  'MS-62',
  'MS-61',
  'MS-60',
  'AU-58',
  'AU-55',
  'AU-53',
  'AU-50',
  'XF-45',
  'XF-40',
  'VF-35',
  'VF-30',
  'VF-25',
  'VF-20',
  'F-15',
  'F-12',
  'VG-10',
  'VG-8',
  'G-6',
  'G-4',
  'AG-3',
  'FR-2',
  'PO-1',
];

class AddCoinView extends StatefulWidget {
  final Coin? coin;
  final bool addToWantlist;
  final bool edit;

  AddCoinView({
    required this.addToWantlist,
    required this.edit,
    this.coin,
  });

  @override
  _AddCoinViewState createState() => _AddCoinViewState(
        coin ?? Coin(inCollection: !addToWantlist),
        addToWantlist,
        edit,
      );
}

class _AddCoinViewState extends State<AddCoinView> {
  late Coin coin;
  final bool addToWantlist;
  final bool edit;
  CoinCollectionModel? model;

  List<String> _coinTypes = [];
  List<String> _variations = [];

  _AddCoinViewState(this.coin, this.addToWantlist, this.edit);

  getImageUrls(
    CoinCollectionModel model,
    String? manualType,
    String? manualGrade,
  ) {
    var photogradeType = manualType ??
        CoinType.coinTypeFromString(coin.type, model.coinTypes)
            ?.photogradeName ??
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

  String? handleDataSource(DataSource? source, Function onAuto) {
    if (source == DataSource.auto) {
      return onAuto();
    } else if (source == DataSource.none) {
      return null;
    }
  }

  addCoin(CoinCollectionModel model) async {
    if (coin.type != '') {
      if (coin.variation != null) {
        handleDataSource(
          coin.mintageSource,
          () => coin.mintage = model
                  .greysheetStaticData![CoinType.coinTypeFromString(
                        coin.type,
                        model.coinTypes,
                      )?.getGreysheetName() ??
                      coin.type]?[coin.variation]
                  ?.mintage ??
              null,
        );
        handleDataSource(
          coin.retailPriceSource,
          () async {
            coin.retailPrice = await GreysheetScraper.retailPriceForCoin(
              coin,
              model.greysheetStaticData ?? Map(),
              model.coinTypes,
            );
            coin.retailPriceLastUpdated = DateTime.now();
          },
        );
      }
      coin.images = getImageUrls(
        model,
        coin.photogradeName,
        coin.photogradeGrade,
      );
      coin.dateAdded = DateTime.now();
      model.addCoin(coin);
      Navigator.of(context).pop();
    }
  }

  static String gradeToNumber(String grade) {
    var gradeSplit = grade.split(' ');
    var gradePart = grade;
    if (gradeSplit.length > 1) gradePart = gradeSplit[0];
    switch (gradePart.length) {
      case 4:
        return gradePart.substring(2, 4);
      case 3:
        if (gradePart[0] == 'F') {
          return gradePart.substring(1, 3);
        }
        return gradePart[2];
      case 2:
        return gradePart[1];
      default:
        return '';
    }
  }

  Future<bool> _onWillPop() async {
    if (edit) {
      await model?.saveCoins();
      model?.refresh();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        this.model = model;
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
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
                    coin.type = type;
                    setState(() {
                      _variations = model
                              .greysheetStaticData?[coin.typeId]?.keys
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
                MultiSourceTextField(
                  label: 'Retail Price',
                  initialValueManual: coin.retailPrice ?? '',
                  initialDataSource: coin.retailPriceSource,
                  onChanged: (price) => coin.retailPrice = price,
                  onRadioChanged: (source) =>
                      coin.retailPriceSource = source ?? DataSource.auto,
                ),
                MultiSourceTextField(
                  label: 'Mintage',
                  initialValueManual: coin.mintage ?? '',
                  initialDataSource: coin.mintageSource,
                  onChanged: (mintage) => coin.mintage = mintage,
                  onRadioChanged: (source) =>
                      coin.mintageSource = source ?? DataSource.auto,
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
                !edit
                    ? RoundedButton(
                        label: 'Add Coin',
                        onPressed: () => addCoin(model),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
