import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/currency_symbol.dart';
import 'components/delete_coin_dialog.dart';
import 'components/detail.dart';

class CoinDetailsView extends StatefulWidget {
  final CoinCollectionModel model;
  final Coin coin;

  const CoinDetailsView(this.model, this.coin, {Key? key}) : super(key: key);

  @override
  _CoinDetailsViewState createState() =>
      _CoinDetailsViewState(this.model, this.coin);
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  final CoinCollectionModel model;
  final Coin coin;

  String? _coinValue;

  _CoinDetailsViewState(this.model, this.coin) {
    _coinValue = '\$${coin.retailPrice?.value?.toStringAsFixed(2) ?? ''}';
  }

  bool usePCGS(dynamic value) {
    if ((double.tryParse(value?.toString() ?? '') ?? 0) < 0) {
      return true;
    }
    return false;
  }

  String? get denomination {
    if (coin.currencySymbol == CurrencySymbol.CENT) {
      return '${coin.denomination}${coin.currencySymbol?.symbol}';
    } else if (coin.currencySymbol != CurrencySymbol.UNKNOWN) {
      return '${coin.currencySymbol?.symbol}${coin.denomination}';
    } else {
      return null;
    }
  }

  Color? get gradeColor {
    final gradeSplit = (coin.grade ?? '').split('-');
    if (gradeSplit.length >= 2) {
      int gradeValue = int.tryParse(gradeSplit[1]) ?? 0;
      if (gradeValue < 10) {
        return Colors.red;
      } else if (gradeValue < 50) {
        return Colors.orange;
      } else if (gradeSplit[0] != 'PR') {
        return Colors.green;
      } else {
        return Colors.blue;
      }
    }
    return null;
  }

  Color? get compositionColor {
    if (coin.composition != null) {
      switch (coin.composition) {
        case 'Gold':
          return Colors.yellow;
        case 'Silver':
          return Colors.grey;
        case 'Nickel':
          return Colors.blueGrey[400]!;
        case 'Copper':
          return Colors.brown[400]!;
        default:
          return null;
      }
    }
    return null;
  }

  MaterialStateProperty<T> msp<T>(T property) {
    return MaterialStateProperty.all<T>(property);
  }

  _showDeleteCoinDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return DeleteCoinDialog(model, coin);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00417a),
        title: Text(
          coin.type,
          style: GoogleFonts.comfortaa(),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 0.9,
              enableInfiniteScroll: false,
            ),
            items: (coin.images ?? []).map(
              (image) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        image: AssetImage(
                          'assets/images/$image',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.type,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                Detail(
                  name: 'Grade',
                  value: coin.grade,
                  color: gradeColor,
                ),
                Detail(
                  name: 'Year',
                  value: coin.year,
                ),
                Detail(
                  name: 'Mint Mark',
                  value: coin.mintMark,
                ),
                Detail(
                  name: 'Denomination',
                  value: denomination,
                ),
                Detail(
                  name: 'Composition',
                  value: coin.composition,
                  color: compositionColor,
                ),
                Detail(
                  name: 'Price',
                  value: _coinValue,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: msp(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: msp(Colors.red),
                    padding: msp(EdgeInsets.only(top: 12, bottom: 12)),
                    textStyle: msp(GoogleFonts.comfortaa(fontSize: 20)),
                  ),
                  onPressed: () => _showDeleteCoinDialog(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, size: 28),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
