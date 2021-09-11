import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:web_scraper/web_scraper.dart';

class GreysheetScraper {
  static final scraper = WebScraper("https://www.greysheet.com/");
  static Map<String, Map<String, GreysheetStaticData>>? staticData;

  static Future<String?> retailPriceForCoin(Coin coin) =>
      _scrapeRetailPriceFromGreysheet(
        staticData?[CoinType.coinTypeFromString(coin.type.value)
                    ?.getGreysheetName(coin.isProof)]?[coin.variation.value]
                ?.pricesUrl ??
            '',
        coin.grade.value.replaceAll('-', ''),
      );

  static Future<String?> _scrapeRetailPriceFromGreysheet(
    String route,
    String grade,
  ) async {
    if (await scraper
        .loadWebPage(route)
        .timeout(const Duration(seconds: 5))
        .onError((error, stackTrace) => false)) {
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
      if (grades.length == prices.length && prices.isNotEmpty) {
        return prices[grades.indexOf(grade)];
      }
      return null;
    }
    return null;
  }
}
