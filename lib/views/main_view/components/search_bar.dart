import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/app_model.dart';
import 'package:provider/provider.dart';

import '../../../components/autocomplete_input.dart';

class SearchBar extends StatefulWidget {
  final bool viewingWantlist;

  const SearchBar(this.viewingWantlist, {Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  AppModel? _model;
  List<String> get _searchOptions => widget.viewingWantlist
      ? _model?.wantlist.map((e) => e.description).toList() ?? []
      : _model?.collection.map((e) => e.description).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        _model = model;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: AutocompleteInput(
            reference: model.searchString,
            options: _searchOptions,
            padding: false,
            refresh: model.refresh,
            fontColor: ViewConstants.accentColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: ViewConstants.primaryColor,
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: ViewConstants.accentColor,
              ),
              contentPadding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
