import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              coin.type,
              style: GoogleFonts.comfortaa(),
            ),
          ),
          body: ListView(
            children: [
              CoinImageCarousel(coin),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        coin.fullType,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Detail(name: 'Grade', value: coin.grade),
                    Detail(name: 'Mintage', value: coin.mintage),
                    Detail(name: 'Retail Price', value: coin.retailPrice),
                    RoundedButton(
                      label:
                          'Move to ${coin.inCollection ? 'Wantlist' : 'Collection'}',
                      onPressed: () => model.toggleInCollectino(coin),
                    ),
                    RoundedButton(
                      label: 'Delete',
                      onPressed: _showDeleteCoinDialog,
                      color: Colors.red[400],
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
