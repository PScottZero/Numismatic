import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

import 'autocomplete_input.dart';

class SearchBar extends StatefulWidget {
  final bool viewingWantlist;

  const SearchBar(this.viewingWantlist, {Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  CoinCollectionModel? _model;
  List<String> get _searchOptions => widget.viewingWantlist
      ? _model?.wantlist.map((e) => e.fullType).toList() ?? []
      : _model?.collection.map((e) => e.fullType).toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return Padding(
          padding: ViewConstants.searchBarPadding,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AutocompleteInput(
                reference: model.searchString,
                options: _searchOptions,
                padding: false,
                refresh: model.refresh,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ViewConstants.colorSearchBar,
                  contentPadding: ViewConstants.searchBarContentPadding,
                  border: OutlineInputBorder(
                    borderRadius: ViewConstants.borderRadiusMedium,
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: ViewConstants.leftPaddingLarge,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: ViewConstants.iconSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
