import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/data_source.dart';
import 'package:numismatic/scraper/greysheet-scraper.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:numismatic/views/components/coin_image_carousel.dart';
import 'package:numismatic/views/components/rounded_button.dart';
import 'package:provider/provider.dart';

import 'components/delete_coin_dialog.dart';
import 'components/detail.dart';

class CoinDetailsView extends StatefulWidget {
  final Coin coin;

  const CoinDetailsView(this.coin, {Key? key}) : super(key: key);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState(this.coin);
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  final Coin coin;

  _CoinDetailsViewState(this.coin);

  _showDeleteCoinDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return DeleteCoinDialog(coin);
      },
    );
  }

  refreshRetailPrice(CoinCollectionModel model) async {
    var thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    if ((this.coin.retailPriceLastUpdated ?? DateTime.now())
        .isBefore(thirtyDaysAgo)) {
      coin.retailPrice = await GreysheetScraper.retailPriceForCoin(
        coin,
        model.greysheetStaticData ?? Map(),
        model.coinTypes,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        refreshRetailPrice(model);
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
                        height: ViewConstants.lineHeight,
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
                      color: ViewConstants.warningColor,
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
