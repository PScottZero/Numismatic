import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:numismatic/components/autocomplete_input.dart';
import 'package:numismatic/components/coin_data_text_field.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/components/image_selector.dart';
import 'package:numismatic/components/loading_dialog.dart';
import 'package:numismatic/components/multi_source_field.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/model/grades.dart';
import 'package:numismatic/scraper/greysheet_scraper.dart';
import 'package:provider/provider.dart';

class AddCoinView extends StatefulWidget {
  final Coin? coin;
  final bool addToWantlist;
  final bool edit;

  const AddCoinView({
    this.addToWantlist = false,
    this.edit = false,
    this.coin,
    Key? key,
  }) : super(key: key);

  @override
  _AddCoinViewState createState() => _AddCoinViewState();
}

class _AddCoinViewState extends State<AddCoinView> {
  Coin _coin = Coin.empty();
  List<String> get _variations =>
      _model?.greysheetStaticData?[_coin.typeId]?.keys.toList() ?? [];
  CoinCollectionModel? _model;

  String get title => widget.addToWantlist ? 'Wantlist' : 'Collection';

  @override
  void initState() {
    super.initState();
    _coin = (widget.coin != null && widget.edit)
        ? Coin.copyOf(widget.coin!)
        : Coin.empty(inCollection: !widget.addToWantlist);
  }

  Future<List<String>> getImagesFromPCGS(
    String? manualName,
    String? manualGrade,
  ) async {
    var photogradeType = manualName ??
        CoinType.coinTypeFromString(_coin.type.value)?.getPhotogradeName() ??
        '';
    var grade = manualGrade ?? gradeToNumber(_coin.grade.value);
    var urls = [
      '${ViewConstants.pcgsUrl}$photogradeType-${grade}o.jpg',
      '${ViewConstants.pcgsUrl}$photogradeType-${grade}r.jpg',
    ];
    List<String> images = [];
    for (var url in urls) {
      var response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5))
          .onError((error, stackTrace) => Response('Error', 500));
      if (response.statusCode == 200) {
        images.add(base64Encode(response.bodyBytes));
      }
    }
    return images;
  }

  String? formatRetailPrice(String? price) {
    price = price?.replaceAll('\$', '').replaceAll(',', '');
    var priceDouble = double.tryParse(price ?? '');
    if (priceDouble != null) {
      return '\$${priceDouble.toStringAsFixed(2)}';
    } else {
      return price;
    }
  }

  handleDataSource(
      DataSource? source, AsyncCallback onAuto, VoidCallback onNull) async {
    if (source == DataSource.auto) {
      return await onAuto();
    } else if (source == DataSource.none) {
      return onNull();
    }
  }

  addCoin() async {
    if (_coin.type.valueNullable != null &&
        _coin.variation.valueNullable != null) {
      if (_coin.variation.valueNullable != null) {
        showDialog(
          context: context,
          builder: (context) {
            return const LoadingDialog();
          },
        );
        await handleDataSource(
          _coin.mintageSource,
          () async => _coin.mintage = _model
              ?.greysheetStaticData![
                  CoinType.coinTypeFromString(_coin.type.value)
                          ?.getGreysheetName(_coin.isProof) ??
                      _coin.type.value]?[_coin.variation.value]
              ?.mintage,
          () => _coin.mintage = null,
        );
        await handleDataSource(
          _coin.retailPriceSource,
          () async {
            if (_coin.grade.valueNullable != null) {
              _coin.retailPrice =
                  await GreysheetScraper.retailPriceForCoin(_coin);
              _coin.retailPriceLastUpdated = DateTime.now();
            }
          },
          () => _coin.retailPrice = null,
        );
      }
      await handleDataSource(
        _coin.imagesSource,
        () async {
          _coin.images = await getImagesFromPCGS(
            _coin.photogradeName,
            _coin.grade.valueNullable != null ? _coin.photogradeGrade : "64",
          );
        },
        () => _coin.images = null,
      );
      if ((_coin.images?.length ?? -1) == 0) {
        _coin.images = null;
      }
      var yearAndMintMark = HelperFunctions.yearAndMintMarkFromVariation(
        _coin.variation.value,
      );
      _coin.year = yearAndMintMark.item1;
      _coin.mintMark = yearAndMintMark.item2;
      _coin.retailPrice = formatRetailPrice(_coin.retailPrice);
      if (widget.edit) {
        _model?.overwriteCoin(widget.coin!, _coin);
      } else {
        _coin.dateAdded = DateTime.now();
        _model?.addCoin(_coin);
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Must specify type and variation',
            style: TextStyle(
              fontSize: ViewConstants.fontSmall,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  static String gradeToNumber(String grade) {
    var gradeSplit = grade.split('-');
    if (gradeSplit.length > 1) {
      var grade = int.tryParse(gradeSplit[1]);
      return grade != null ? grade.toString().padLeft(2, '0') : '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return CustomScaffold(
          appBarTitle: '${widget.edit ? 'Edit' : 'Add'} Coin',
          body: ListView(
            padding: ViewConstants.paddingAllLarge,
            children: [
              AutocompleteInput(
                label: 'Type',
                reference: _coin.type,
                options: CoinType.allCoinTypes,
                decoration: ViewConstants.decorationInput(
                  MediaQuery.of(context).platformBrightness,
                ),
                refresh: () => setState(() {}),
                required: true,
              ),
              AutocompleteInput(
                label: 'Variation',
                reference: _coin.variation,
                options: _variations,
                decoration: ViewConstants.decorationInput(
                  MediaQuery.of(context).platformBrightness,
                ),
                required: true,
              ),
              AutocompleteInput(
                label: 'Grade',
                reference: _coin.grade,
                options: grades,
                decoration: ViewConstants.decorationInput(
                  MediaQuery.of(context).platformBrightness,
                ),
              ),
              MultiSourceField<String>(
                label: 'Mintage',
                initialDataSource: _coin.mintageSource,
                manualChild: CoinDataTextField(
                  initialValue: _coin.mintage,
                  onChanged: (mintage) => _coin.mintage = mintage,
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
                  onChanged: (price) => _coin.retailPrice = price,
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
                    _coin.images = images.isNotEmpty ? images : null;
                  },
                ),
                onRadioChanged: (source) {
                  _coin.imagesSource = source ?? DataSource.auto;
                },
              ),
              CoinDataTextField(
                label: 'Notes',
                initialValue: _coin.notes,
                onChanged: (notes) => _coin.notes = notes,
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Advanced',
                  style: TextStyle(
                    fontSize: ViewConstants.fontMedium,
                  ),
                ),
                children: [
                  CoinDataTextField(
                    label: 'Photograde Name',
                    initialValue: _coin.photogradeName,
                    onChanged: (name) => _coin.photogradeName = name,
                  ),
                  CoinDataTextField(
                    label: 'Photograde Grade',
                    initialValue: _coin.photogradeGrade,
                    onChanged: (grade) => _coin.photogradeGrade = grade,
                  ),
                ],
              ),
              RoundedButton(
                label: widget.edit ? 'Save Changes' : 'Add To $title',
                onPressed: () => addCoin(),
              ),
              SizedBox(height: Platform.isIOS ? ViewConstants.gapSmall : 0),
            ],
          ),
        );
      },
    );
  }
}
