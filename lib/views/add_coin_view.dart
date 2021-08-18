import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCoinView extends StatefulWidget {
  const AddCoinView({Key? key}) : super(key: key);

  @override
  _AddCoinViewState createState() => _AddCoinViewState();
}

class _AddCoinViewState extends State<AddCoinView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00417a),
        title: Text(
          'Add Coin',
          style: GoogleFonts.comfortaa(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(),
        ],
      ),
    );
  }
}
