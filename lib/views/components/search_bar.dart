import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/autocomplete_input.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool viewingWantlist;

  const SearchBar(this.viewingWantlist);

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
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                  fillColor: Colors.blueGrey[600],
                  contentPadding: EdgeInsets.fromLTRB(50, 10, 10, 10),
                  border: OutlineInputBorder(
                    borderRadius: ViewConstants.borderRadiusMedium,
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
