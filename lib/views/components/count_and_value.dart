import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';

class CountAndValue extends StatelessWidget {
  final List<Coin> coins;

  String get totalValue {
    if (coins.length > 0) {
      var sum = coins
          .map(
            (e) => double.tryParse(
              e.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
            ),
          )
          .toList()
          .reduce((sum, element) => (sum ?? 0) + (element ?? 0));
      return '\$${(sum ?? 0.0).toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  const CountAndValue(this.coins);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ViewConstants.colorPrimary,
        borderRadius: ViewConstants.borderRadiusMedium,
      ),
      padding: ViewConstants.paddingAllLarge(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count: ${coins.length.toString()}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ViewConstants.gapSmall),
            Text(
              'Total Value:\n$totalValue',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
