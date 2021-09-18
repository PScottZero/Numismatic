import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';

class CustomScaffold extends StatelessWidget {
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget? appBarBottom;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    required this.appBarTitle,
    this.appBarActions,
    this.appBarBottom,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ViewConstants.colorBackground
              : ViewConstants.colorBackgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        title: Padding(
          padding: ViewConstants.paddingLeftSmall,
          child: Text(
            appBarTitle,
            style: GoogleFonts.quicksand(
              fontSize: ViewConstants.fontMedium,
            ),
          ),
        ),
        actions: appBarActions,
        bottom: appBarBottom,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
