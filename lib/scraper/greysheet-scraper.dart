import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:tuple/tuple.dart';
import 'package:web_scraper/web_scraper.dart';

class GreysheetScraper {
  static final scraper = WebScraper("https://www.greysheet.com/");

  static Future<List<Tuple2<String, String>>?> retailPriceForCoin(
    Coin coin,
    Map<String, Map<String, GreysheetStaticData>> staticData,
    List<CoinType> coinTypes,
  ) =>
      _scrapeRetailPriceFromGreysheet(
        staticData[CoinType.coinTypeFromString(coin.type, coinTypes)
                        ?.getGreysheetName() ??
                    coin.type]?[coin.variation]
                ?.pricesUrl ??
            '',
        coin.grade ?? '',
      );

  static Future<List<Tuple2<String, String>>?> _scrapeRetailPriceFromGreysheet(
    String route,
    String grade,
  ) async {
    if (await scraper.loadWebPage(route)) {
      var grades = scraper
          .getElement('p.entry-title', [])
          .map((e) => e['title'].toString().trim())
          .toList();
      var prices = scraper
          .getElement('button.button-cpg-value', [])
          .map(
            (e) => e['title']
                .toString()
                .replaceAll('CPG:', '')
                .replaceAll(' ', '')
                .trim(),
          )
          .toList();
      List<Tuple2<String, String>> gradesAndPrices = [];
      if (grades.length == prices.length) {
        for (var i = 0; i < grades.length; i++) {
          gradesAndPrices.add(Tuple2(grades[i], prices[i]));
        }
        return gradesAndPrices;
      }
      return null;
    }
    return null;
  }
}
