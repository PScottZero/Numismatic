import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/coin_card.dart';
import 'package:provider/provider.dart';

class CoinGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Numismatic',
              style: GoogleFonts.comfortaa(color: Colors.white),
            ),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: model.collection.map((e) => CoinCard(e)).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.cyan,
          ),
        );
      },
    );
  }
}
