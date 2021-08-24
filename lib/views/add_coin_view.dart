import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/coin_type_input.dart';
import 'package:numismatic/views/components/data_input.dart';
import 'package:provider/provider.dart';

class AddCoinView extends StatefulWidget {
  const AddCoinView({Key? key}) : super(key: key);

  @override
  _AddCoinViewState createState() => _AddCoinViewState();
}

class _AddCoinViewState extends State<AddCoinView> {
  final Coin coin = Coin("");

  MaterialStateProperty<T> msp<T>(T property) {
    return MaterialStateProperty.all<T>(property);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff00417a),
            title: Text(
              'Add Coin',
              style: GoogleFonts.comfortaa(),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(30),
            children: [
              CoinTypeInput(coin),
              DataInput("Year", coin),
              DataInput("Mint Mark", coin),
              DataInput("Variation", coin),
              DataInput("Grade", coin),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  shape: msp(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor: msp(Colors.green),
                  padding: msp(EdgeInsets.only(top: 12, bottom: 12)),
                  textStyle: msp(GoogleFonts.comfortaa(fontSize: 20)),
                ),
                onPressed: () {
                  model.addCoin(coin);
                  Navigator.of(context).pop();
                },
                child: Text('Add Coin'),
              ),
            ],
          ),
        );
      },
    );
  }
}
