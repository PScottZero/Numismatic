import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final bool hasAppBar;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final PreferredSizeWidget? appBarBottom;
  final Color? appBarColor;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const MyScaffold({
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
      appBar: hasAppBar
          ? AppBar(
              title: Text(appBarTitle),
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
