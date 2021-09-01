import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:web_scraper/web_scraper.dart';

class GreysheetScraper {
  static final scraper = WebScraper("https://www.greysheet.com/");
  static Map<String, Map<String, GreysheetStaticData>>? staticData;

  static Future<String?> retailPriceForCoin(Coin coin) =>
      _scrapeRetailPriceFromGreysheet(
        staticData?[CoinType.coinTypeFromString(coin.type)
                        ?.getGreysheetName() ??
                    coin.type]?[coin.variation]
                ?.pricesUrl ??
            '',
        coin.grade?.replaceAll('-', '') ?? '',
      );

  static Future<String?> _scrapeRetailPriceFromGreysheet(
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
      if (grades.length == prices.length) {
        return prices[grades.indexOf(grade)];
      }
      return null;
    }
    return null;
  }
}
