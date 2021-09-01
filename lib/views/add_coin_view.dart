import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/model/grades.dart';
import 'package:numismatic/scraper/greysheet_scraper.dart';
import 'package:numismatic/views/components/autocomplete_input.dart';
import 'package:numismatic/views/components/coin_data_text_field.dart';
import 'package:numismatic/views/components/multi_source_field.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

import 'components/image_selector.dart';

class AddCoinView extends StatefulWidget {
  final Coin? coin;
  final bool addToWantlist;
  final bool edit;
  final int coinIndex;

  Coin get coinParameter {
    if (coin != null && edit) {
      return Coin.copyOf(coin!);
    }
    return Coin(inCollection: !addToWantlist);
  }

  AddCoinView({
    required this.addToWantlist,
    required this.edit,
    this.coin,
    this.coinIndex = -1,
  });

  @override
  _AddCoinViewState createState() => _AddCoinViewState(coinParameter);
}

class _AddCoinViewState extends State<AddCoinView> {
  Coin _coin;
  List<String> _variations = [];
  CoinCollectionModel? modelRef;

  _AddCoinViewState(this._coin);

  Future<List<String>> getImagesFromPCGS(
    String? manualName,
    String? manualGrade,
  ) async {
    var photogradeType = manualName ??
        CoinType.coinTypeFromString(_coin.type)?.photogradeName ??
        '';
    var grade = manualGrade ?? gradeToNumber(_coin.grade!);
    var urls = [
      '${ViewConstants.pcgsUrl}$photogradeType-${grade}o.jpg',
      '${ViewConstants.pcgsUrl}$photogradeType-${grade}r.jpg',
    ];
    List<String> images = [];
    for (var url in urls) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        images.add(base64Encode(response.bodyBytes));
      }
    }
    return images;
  }

  String? nullIfEmpty(String? str) => str != '' ? str : null;

  handleDataSource(DataSource? source, AsyncCallback onAuto) async {
    if (source == DataSource.auto) {
      return await onAuto();
    } else if (source == DataSource.none) {
      return null;
    }
  }

  addCoin() async {
    if (_coin.type != '') {
      if (_coin.variation != null) {
        await handleDataSource(
          _coin.mintageSource,
          () async => _coin.mintage = modelRef
                  ?.greysheetStaticData![CoinType.coinTypeFromString(_coin.type)
                          ?.getGreysheetName() ??
                      _coin.type]?[_coin.variation]
                  ?.mintage ??
              null,
        );
        await handleDataSource(
          _coin.retailPriceSource,
          () async {
            _coin.retailPrice =
                await GreysheetScraper.retailPriceForCoin(_coin);
            _coin.retailPriceLastUpdated = DateTime.now();
          },
        );
      }
      await handleDataSource(
        _coin.imagesSource,
        () async {
          _coin.images = await getImagesFromPCGS(
            _coin.photogradeName,
            _coin.photogradeGrade,
          );
        },
      );
      if ((_coin.images?.length ?? -1) == 0) {
        _coin.images = null;
      }
      if (widget.edit && widget.coinIndex >= 0) {
        modelRef?.overwriteCoin(widget.coinIndex, _coin);
        modelRef?.refresh();
      } else {
        _coin.dateAdded = DateTime.now();
        modelRef?.addCoin(_coin);
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
        _variations =
            model.greysheetStaticData?[_coin.typeId]?.keys.toList() ?? [];
        modelRef = model;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${widget.edit ? 'Edit' : 'Add'} Coin',
              style: GoogleFonts.comfortaa(),
            ),
          ),
          body: ListView(
            padding: ViewConstants.paddingAllLarge(),
            children: [
              AutocompleteInput(
                label: 'Coin Type',
                initialValue: _coin.type,
                options: model.allCoinTypes,
                onChanged: (type) {
                  setState(() {
                    _coin.type = type;
                    _variations = model.greysheetStaticData?[_coin.typeId]?.keys
                            .toList() ??
                        [];
                  });
                },
                required: true,
              ),
              AutocompleteInput(
                label: 'Variation',
                initialValue: _coin.variation ?? '',
                options: _variations,
                onChanged: (variation) {
                  _coin.variation = nullIfEmpty(variation);
                  var yearAndMintMark =
                      HelperFunctions.yearAndMintMarkFromVariation(variation);
                  _coin.year = nullIfEmpty(yearAndMintMark?.item1);
                  _coin.mintMark = nullIfEmpty(yearAndMintMark?.item2);
                },
                required: true,
              ),
              AutocompleteInput(
                label: 'Grade',
                initialValue: _coin.grade ?? '',
                options: grades,
                onChanged: (grade) {
                  _coin.grade = nullIfEmpty(grade);
                },
              ),
              MultiSourceField<String>(
                label: 'Mintage',
                initialDataSource: _coin.mintageSource,
                manualChild: CoinDataTextField(
                  initialValue: _coin.mintage,
                  onChanged: (mintage) => _coin.mintage = nullIfEmpty(mintage),
                ),
                onRadioChanged: (source) {
                  _coin.mintageSource = source ?? DataSource.auto;
                },
              ),
              MultiSourceField<String>(
                label: 'Retail Price',
                initialDataSource: _coin.retailPriceSource,
                manualChild: CoinDataTextField(
                  initialValue: _coin.retailPrice,
                  onChanged: (price) => _coin.retailPrice = nullIfEmpty(price),
                ),
                onRadioChanged: (source) {
                  _coin.retailPriceSource = source ?? DataSource.auto;
                },
              ),
              MultiSourceField<List<String>>(
                label: 'Images',
                initialDataSource: _coin.imagesSource,
                manualChild: ImageSelector(
                  existingImages: _coin.images ?? [],
                  callback: (images) {
                    _coin.images = images.length > 0 ? images : null;
                  },
                ),
                onRadioChanged: (source) {
                  _coin.imagesSource = source ?? DataSource.auto;
                },
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
                    label: 'Photograde Name',
                    onChanged: (name) =>
                        _coin.photogradeName = nullIfEmpty(name),
                  ),
                  CoinDataTextField(
                    label: 'Photograde Grade',
                    onChanged: (grade) =>
                        _coin.photogradeGrade = nullIfEmpty(grade),
                  ),
                ],
              ),
              RoundedButton(
                label: widget.edit ? 'Save Changes' : 'Add Coin',
                onPressed: () => addCoin(),
              )
            ],
          ),
        );
      },
    );
  }
}
