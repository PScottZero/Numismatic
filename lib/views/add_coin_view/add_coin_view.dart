import 'dart:io';

import 'package:flutter/material.dart';
import 'package:numismatic/components/autocomplete_input.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/views/add_coin_view/components/coin_data_text_field.dart';
import 'package:numismatic/views/add_coin_view/components/image_selector.dart';
import 'package:numismatic/views/settings_view/components/loading_dialog.dart';
import 'package:numismatic/views/add_coin_view/components/multi_source_field.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/model/grades.dart';
import 'package:numismatic/services/coin_data_retriever.dart';
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

  String? formatRetailPrice(String? price) {
    price = price?.replaceAll('\$', '').replaceAll(',', '');
    var priceDouble = double.tryParse(price ?? '');
    if (priceDouble != null) {
      return '\$${priceDouble.toStringAsFixed(2)}';
    } else {
      return price;
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
        await CoinDataRetriever.setMintage(_coin, _model);
        await CoinDataRetriever.setRetailPrice(_coin, _model);
        await CoinDataRetriever.setImages(_coin, _model);
      }
      if (_coin.images?.isEmpty ?? false) {
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
              fontSize: ViewConstants.mediumFont,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  String? _nullIfEmpty(String? str) => str != '' ? str : null;

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return CustomScaffold(
          appBarTitle: '${widget.edit ? 'Edit' : 'Add'} Coin',
          body: ListView(
            padding: ViewConstants.largePadding,
            children: [
              AutocompleteInput(
                label: 'Type',
                reference: _coin.type,
                options: CoinType.allCoinTypes,
                decoration: ViewConstants.decorationInput(context),
                refresh: () => setState(() {}),
                required: true,
              ),
              AutocompleteInput(
                label: 'Variation',
                reference: _coin.variation,
                options: _variations,
                decoration: ViewConstants.decorationInput(context),
                required: true,
              ),
              AutocompleteInput(
                label: 'Grade',
                reference: _coin.grade,
                options: grades,
                decoration: ViewConstants.decorationInput(context),
              ),
              MultiSourceField<String>(
                label: 'Mintage',
                initialDataSource: _coin.mintageSource,
                manualChild: CoinDataTextField(
                  initialValue: _coin.mintage,
                  onChanged: (mintage) => _coin.mintage = _nullIfEmpty(mintage),
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
                  onChanged: (price) => _coin.retailPrice = _nullIfEmpty(price),
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
                onChanged: (notes) => _coin.notes = _nullIfEmpty(notes),
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Advanced',
                  style: TextStyle(
                    fontSize: ViewConstants.largeFont,
                  ),
                ),
                children: [
                  CoinDataTextField(
                    label: 'Photograde Grade',
                    initialValue: _coin.photogradeGrade,
                    onChanged: (grade) =>
                        _coin.photogradeGrade = _nullIfEmpty(grade),
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
