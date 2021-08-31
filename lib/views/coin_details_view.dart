import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/scraper/greysheet-scraper.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:numismatic/views/components/coin_image_carousel.dart';
import 'package:numismatic/views/components/confirm_cancel_dialog.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

import 'components/detail.dart';

class CoinDetailsView extends StatefulWidget {
  final int coinIndex;

  const CoinDetailsView(this.coinIndex);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState(this.coinIndex);
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  final int coinIndex;
  CoinCollectionModel? _modelRef;

  _CoinDetailsViewState(this.coinIndex);

  init(CoinCollectionModel model) {
    _modelRef = model;
    var coin = model.coinAtIndex(coinIndex);
    if (coin != null) {
      var thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
      if ((coin.retailPriceLastUpdated ?? DateTime.now())
          .isBefore(thirtyDaysAgo)) {
        setState(() async {
          coin.retailPrice = await GreysheetScraper.retailPriceForCoin(coin);
        });
      }
    }
  }

  _showDeleteCoinDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Delete Coin',
          message: 'Are you sure you want to delete this coin?',
          confirmAction: 'Delete',
          onConfirmed: () {
            _modelRef?.deleteCoin(coinIndex);
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
        init(model);
        var coin = model.coinAtIndex(coinIndex);
        if (coin != null) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                coin.type,
                style: GoogleFonts.comfortaa(),
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
                            coin: coin,
                            addToWantlist: coin.inCollection,
                            edit: true,
                            coinIndex: model.allCoins.indexOf(coin),
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
                CoinImageCarousel(coin),
                Container(
                  padding: ViewConstants.paddingAllLarge(top: false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin.fullType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ViewConstants.fontLarge,
                          fontWeight: FontWeight.bold,
                          height: ViewConstants.spacing1_5,
                        ),
                      ),
                      Detail(name: 'Grade', value: coin.grade),
                      Detail(
                        name: 'Mintage',
                        value: coin.mintageSource != DataSource.none
                            ? coin.mintage
                            : null,
                      ),
                      Detail(
                        name: 'Retail Price',
                        value: coin.retailPriceSource != DataSource.none
                            ? coin.retailPrice
                            : null,
                      ),
                      RoundedButton(
                        label:
                            'Move to ${coin.inCollection ? 'Wantlist' : 'Collection'}',
                        onPressed: () => model.toggleInCollection(coin),
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
        } else {
          return Container();
        }
      },
    );
  }
}
