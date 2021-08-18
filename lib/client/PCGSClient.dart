import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:http/http.dart' as http;

class PCGSClient {
  static final String pcgsUrl = 'https://www.pcgs.com';
  static final pricesUrl = 'prices/detail';

  static Future<int> coinValue(Coin coin) async {
    print(coin);
    final type = coinTypeFromString(coin.type);
    final typePath = _coinTypeToPath(coin.type);
    final typeIntPath = _coinTypeToInt[type];
    final gradePath = _gradePathFromString(coin.grade ?? '');
    print(type);
    if (type != null) {
      var url =
          Uri.parse('$pcgsUrl/$pricesUrl/$typePath/$typeIntPath/$gradePath/');
      print(url);
      var response = await http.get(url);
      print(response.body);
      return 100;
    } else {
      return -1;
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

  static String _coinTypeToPath(String type) =>
      type.toLowerCase().replaceAll(' ', '-');

  static Map<CoinType, int> _coinTypeToInt = {
    CoinType.flowingHairDollar: 736,
    CoinType.morganDollar: 744
  };
}
