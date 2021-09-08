import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:numismatic/views/components/confirm_cancel_dialog.dart';
import 'package:numismatic/views/components/image_carousel.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

import 'components/detail.dart';

class CoinDetailsView extends StatefulWidget {
  final Coin coin;

  const CoinDetailsView(this.coin);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState();
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  CoinCollectionModel? _modelRef;

  _showDeleteCoinDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Delete Coin',
          message: 'Are you sure you want to delete this coin?',
          confirmAction: 'Delete',
          onConfirmed: () {
            _modelRef?.deleteCoin(widget.coin);
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
        _modelRef = model;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.coin.fullType,
              style: GoogleFonts.quicksand(),
              textAlign: TextAlign.center,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(10),
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
                  child: Icon(Icons.edit),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              widget.coin.images != null
                  ? ImageCarousel(widget.coin.images)
                  : Container(),
              Container(
                padding: ViewConstants.paddingAllLarge(
                  top: widget.coin.images == null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.coin.fullType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ViewConstants.fontLarge,
                          fontWeight: FontWeight.bold,
                          height: ViewConstants.spacing1_5,
                        ),
                      ),
                    ),
                    Detail(name: 'Grade', value: widget.coin.grade.value),
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
                    ),
                    RoundedButton(
                      label: 'Delete',
                      onPressed: _showDeleteCoinDialog,
                      color: ViewConstants.colorWarning,
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
