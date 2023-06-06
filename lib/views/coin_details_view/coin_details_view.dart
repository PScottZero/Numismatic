import 'package:flutter/material.dart';
import 'package:numislog/components/confirm_cancel_dialog.dart';
import 'package:numislog/components/my_scaffold.dart';
import 'package:numislog/views/coin_details_view/components/detail.dart';
import 'package:numislog/views/coin_details_view/components/image_carousel.dart';
import 'package:numislog/components/my_elevated_button.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/coin.dart';
import 'package:numislog/model/app_model.dart';
import 'package:numislog/model/data_source.dart';
import 'package:numislog/views/add_coin_view/add_coin_view.dart';
import 'package:provider/provider.dart';

class CoinDetailsView extends StatefulWidget {
  final Coin coin;

  const CoinDetailsView(this.coin, {Key? key}) : super(key: key);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState();
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  AppModel? _model;

  _showDeleteCoinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmCancelDialog(
          title: 'Delete Coin',
          message: 'Are you sure you want to delete this coin?',
          confirmAction: 'Delete',
          onConfirmed: () {
            _model?.deleteCoin(widget.coin);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        _model = model;
        return MyScaffold(
          appBarTitle: widget.coin.description,
          appBarActions: [
            Padding(
              padding: ViewConstants.smallPadding,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCoinView(
                        coin: widget.coin,
                        addToWantlist: widget.coin.inCollection,
                        edit: true,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ],
          body: ListView(
            children: [
              widget.coin.images != null
                  ? ImageCarousel(widget.coin.images)
                  : Container(),
              Container(
                padding: widget.coin.images == null
                    ? ViewConstants.largePadding
                    : const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.coin.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Detail(
                      name: 'Grade',
                      value: widget.coin.grade.valueNullable,
                    ),
                    Detail(
                      name: 'Mintage',
                      value: widget.coin.mintageSource != DataSource.none
                          ? widget.coin.mintage
                          : null,
                    ),
                    Detail(
                      name: 'Retail Price',
                      value: widget.coin.retailPriceSource != DataSource.none
                          ? widget.coin.retailPrice
                          : null,
                    ),
                    Detail(
                      name: 'Notes',
                      value: widget.coin.notes,
                    ),
                    MyElevatedButton(
                      label:
                          'Move to ${widget.coin.inCollection ? 'Wantlist' : 'Collection'}',
                      onPressed: () => model.toggleInCollection(widget.coin),
                    ),
                    MyElevatedButton(
                      label: 'Delete',
                      onPressed: _showDeleteCoinDialog,
                      warning: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
