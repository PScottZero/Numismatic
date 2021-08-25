import 'package:web_scraper/web_scraper.dart';

class GreysheetScraper {
  static final scraper = WebScraper("https://www.greysheet.com/");

  static Future<double?> scrapeRetailPriceFromGreysheet(
    String route,
    String grade,
  ) async {
    if (await scraper.loadWebPage(route)) {
      var grades = scraper
          .getElement("p.entry-title", [])
          .map((e) => e["title"].toString().trim())
          .toList();
      var prices = scraper
          .getElement("button.button-cpg-value", [])
          .map(
            (e) => e["title"]
                .toString()
                .replaceAll('CPG:', '')
                .replaceAll('\$', '')
                .replaceAll(' ', '')
                .trim(),
          )
          .toList();
      return double.tryParse(prices[grades.indexOf(grade)]);
    }
    return null;
  }
}
