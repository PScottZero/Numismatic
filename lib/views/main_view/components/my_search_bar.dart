import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/autocomplete_input.dart';
import '../../../model/app_model.dart';

class MySearchBar extends StatefulWidget {
  final bool viewingWantlist;

  const MySearchBar(this.viewingWantlist, {Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
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
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: AutocompleteInput(
            reference: model.searchString,
            options: _searchOptions,
            padding: false,
            refresh: model.refresh,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
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
