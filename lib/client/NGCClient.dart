import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:http/http.dart' as http;

class PCGSClient {
  static final String ngcBaseUrl = 'https://www.ngccoin.com';
  static final pricesUrl = 'price-guide/united-states/';

  static Future<String?> coinValue(Coin coin) async {
    final denomination = _denominationOf(coin);
    final coinId = _coinIds[coin];
    if (denomination != null) {
      var url = Uri.parse('$ngcBaseUrl/$pricesUrl/$denomination/$coinId');
      var response = await http.get(url);
      var responseSplit = response.body.split('\n');
      print(responseSplit.length);
      return "100";
    } else {
      return null;
    }
  }

  static String _gradePathFromString(String grade) {
    var gradeRangeString = 'grades';
    final gradeSplit = grade.split('-');
    if (gradeSplit.length >= 2) {
      int? gradeValue = int.tryParse(grade.split('-')[1]);
      String state = grade.split('-')[0];
      if (gradeValue != null) {
        String stateString;
        if (state == 'PR') {
          stateString = 'pr';
        } else {
          stateString = 'ms';
        }
        if (gradeValue <= 20) {
          return '$gradeRangeString-1-20/$stateString';
        } else if (gradeValue <= 60) {
          return '$gradeRangeString-25-60/$stateString';
        } else {
          return '$gradeRangeString-61-70/$stateString';
        }
      }
    }
    return '';
  }

  static String? _denominationOf(Coin coin) {
    switch (coinTypeFromString(coin.type)) {
      case CoinType.morganDollar:
        return 'dollars';
      default:
        return null;
    }
  }

  static String _coinTypeToPath(String type) =>
      type.toLowerCase().replaceAll(' ', '-');

  static Map<CoinType, int> _coinIds = {
    CoinType.flowingHairDollar: 736,
    CoinType.morganDollar: 49
  };
}
