class CoinType {
  String name;
  String? greysheetName;
  String photogradeName;

  CoinType({
    required this.name,
    this.greysheetName,
    required this.photogradeName,
  });

  String getGreysheetName() {
    if (this.greysheetName == null) {
      return "${name}s";
    } else {
      return this.greysheetName!;
    }
  }
}

var coinTypes = [
  // half cents
  CoinType(
    name: "Liberty Cap Half Cent",
    photogradeName: "1793HalfCent",
  ),
  CoinType(
    name: "Draped Bust Half Cent",
    photogradeName: "DrapedHalfCent",
  ),
  CoinType(
    name: "Classic Head Half Cent",
    photogradeName: "ClassicHalfCent",
  ),
  CoinType(
    name: "Braided Hair Half Cent",
    photogradeName: "BraidedHalfCent",
  ),

  // large cents
  CoinType(
    name: "Chain Cent",
    greysheetName: "Flowing Hair Large Cents",
    photogradeName: "ChainCent",
  ),
  CoinType(
    name: "Wreath Cent",
    greysheetName: "Flowing Hair Large Cents",
    photogradeName: "WreathCent",
  ),
  CoinType(
    name: "Liberty Cap Large Cent",
    greysheetName: "Flowing Hair Large Cents",
    photogradeName: "LibertyCapCent",
  ),
  CoinType(
    name: "Draped Bust Large Cent",
    photogradeName: "DrapedBustCent",
  ),
  CoinType(
    name: "Classic Head Large Cent",
    photogradeName: "ClassicCent",
  ),
  CoinType(
    name: "Coronet Head Large Cent",
    photogradeName: "CoronetCent",
  ),
  CoinType(
    name: "Braided Hair Large Cent",
    photogradeName: "BraidedCent",
  ),

  // small cents
  CoinType(
    name: "Flying Eagle Cent",
    photogradeName: "Flyings",
  ),
  CoinType(
    name: "Indian Cent",
    photogradeName: "Indian",
  ),
  CoinType(
    name: "Lincoln Cent (Wheat)",
    greysheetName: "Lincoln Cents - Wheat Reverse",
    photogradeName: "Lincoln",
  ),
  CoinType(
    name: "Lincoln Cent (Memorial)",
    greysheetName: "Lincoln Cents - Memorial Reverse",
    photogradeName: "Lincoln",
  ),

  // two and three cents
  CoinType(
    name: "Two Cent Piece",
    greysheetName: "2-Cent Pieces",
    photogradeName: "TwoCent",
  ),
  CoinType(
    name: "Three Cent Silver",
    greysheetName: "3-Cent Silver",
    photogradeName: "3CentSil",
  ),
  CoinType(
    name: "Three Cent Nickel",
    greysheetName: "3-Cent Nickels",
    photogradeName: "3CentNic",
  ),

  // nickels
  CoinType(
    name: "Shield Nickel",
    photogradeName: "ShieldNic",
  ),
  CoinType(
    name: "Liberty Nickel",
    greysheetName: "V-Nickels",
    photogradeName: "LibNic",
  ),
  CoinType(
    name: "Buffalo Nickel",
    photogradeName: "Buffalo",
  ),
  CoinType(
    name: "Jefferson Nickel",
    photogradeName: "Jefferson",
  ),

  // half dimes
  CoinType(
    name: "Flowing Hair Half Dime",
    photogradeName: "FlowingHalfDime",
  ),
  CoinType(
    name: "Draped Bust Half Dime (Small Eagle)",
    greysheetName: "Draped Bust Half Dimes",
    photogradeName: "DrapedHalfDime",
  ),
  CoinType(
    name: "Draped Bust Half Dime (Large Eagle)",
    greysheetName: "Draped Bust Half Dimes",
    photogradeName: "DrapedHalfDimeLE",
  ),
  CoinType(
    name: "Capped Bust Half Dime",
    photogradeName: "CappedHalfDime",
  )
];
