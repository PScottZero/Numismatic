import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';

class CountAndValue extends StatelessWidget {
  final List<Coin> coins;

  String get totalValue {
    if (coins.isNotEmpty) {
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

  const CountAndValue(this.coins, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ViewConstants.colorPrimary,
        borderRadius: ViewConstants.borderRadiusLarge,
        boxShadow: ViewConstants.boxShadow,
      ),
      padding: ViewConstants.paddingAllSmall,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count: ${coins.length.toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: ViewConstants.fontSmall,
                fontWeight: FontWeight.bold,
                color: ViewConstants.colorAccent,
              ),
            ),
            const SizedBox(height: ViewConstants.gapSmall),
            Text(
              'Total Value:\n$totalValue',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: ViewConstants.fontSmall,
                fontWeight: FontWeight.bold,
                color: ViewConstants.colorAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
