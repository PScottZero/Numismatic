import 'package:flutter/material.dart';
import 'package:numismatic/components/confirm_cancel_dialog.dart';
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/views/coin_details_view/components/detail.dart';
import 'package:numismatic/views/coin_details_view/components/image_carousel.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/views/add_coin_view/add_coin_view.dart';
import 'package:provider/provider.dart';

class CoinDetailsView extends StatefulWidget {
  final Coin coin;

  const CoinDetailsView(this.coin, {Key? key}) : super(key: key);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState();
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  CoinCollectionModel? _model;

  _showDeleteCoinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Delete Coin',
          message: 'Are you sure you want to delete this coin?',
          confirmAction: 'Delete',
          onConfirmed: () {
            _model?.deleteCoin(widget.coin);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return CustomScaffold(
          appBarTitle: widget.coin.description,
          appBarActions: [
            Padding(
              padding: ViewConstants.smallPadding,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCoinView(
                        coin: widget.coin,
                        addToWantlist: widget.coin.inCollection,
                        edit: true,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
          ],
          body: ListView(
            children: [
              widget.coin.images != null
                  ? ImageCarousel(widget.coin.images)
                  : Container(),
              Container(
                padding: widget.coin.images == null
                    ? ViewConstants.largePadding
                    : const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.coin.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Detail(
                        name: 'Grade', value: widget.coin.grade.valueNullable,),
                    Detail(
                      name: 'Mintage',
                      value: widget.coin.mintageSource != DataSource.none
                          ? widget.coin.mintage
                          : null,
                    ),
                    Detail(
                      name: 'Retail Price',
                      value: widget.coin.retailPriceSource != DataSource.none
                          ? widget.coin.retailPrice
                          : null,
                    ),
                    Detail(
                      name: 'Notes',
                      value: widget.coin.notes,
                    ),
                    RoundedButton(
                      label:
                          'Move to ${widget.coin.inCollection ? 'Wantlist' : 'Collection'}',
                      onPressed: () => model.toggleInCollection(widget.coin),
                      color: Colors.cyan[600],
                      textColor: Colors.cyan[100]!,
                    ),
                    RoundedButton(
                      label: 'Delete',
                      onPressed: _showDeleteCoinDialog,
                      color: ViewConstants.warningColor,
                      textColor: ViewConstants.warningAccentColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
