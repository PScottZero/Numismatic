import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/coin_image_carousel.dart';
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

  _CoinDetailsViewState(this.model, this.coin);

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
                Text(
                  coin.fullType,
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
                  name: 'Mintage',
                  value: coin.mintage,
                ),
                Detail(
                  name: 'Retail Price',
                  value: coin.retailPrice,
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
