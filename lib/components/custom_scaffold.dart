import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';

class CustomScaffold extends StatelessWidget {
  final bool hasAppBar;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget? appBarBottom;
  final Color? appBarColor;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    this.hasAppBar = true,
    required this.appBarTitle,
    this.appBarActions,
    this.appBarBottom,
    this.appBarColor,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ViewConstants.backgroundColorFromContext(context),
      appBar: hasAppBar
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              title: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  appBarTitle,
                  style: GoogleFonts.quicksand(
                    fontSize: ViewConstants.largeFont,
                  ),
                ),
              ),
              actions: appBarActions,
              bottom: appBarBottom,
            )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
