enum CoinType {
  // half -ents and cents
  libertyCapHalfCent,
  drapedBustHalfCent,
  classicHeadHalfCent,
  braidedHairHalfCent,
  flowingHairLargeCent,
  drapedBustCent,
  classicHeadCent,
  braidedHairCent,
  flyingEagleCent,
  indianCent,
  lincolnCent_WheatReverse_,
  lincolnCent_Modern_,

  // two and three cents
  twoCent,
  threeCentSilver,
  threeCentNickel,

  // Nickels
  shieldNickel,
  libertyNickel,
  buffaloNickel,
  jeffersonNickel,

  // half-dimes and dimes
  bustHalfDime,
  flowingHairHalfDime,
  drapedBustHalfDime,
  cappedBustHalfDime,
  libertySeatedHalfDime,
  drapedBustDime,
  cappedBustDime,
  libertySeatedDime,
  barberDime,
  mercuryDime,
  rooseveltDime,

  // twenty cents and quarters
  twentyCent,
  drapedBustQuarter,
  cappedBustQuarter,
  libertySeatedQuarter,
  barberQuarter,
  standingLibertyQuarter,
  washingtonQuarter,
  washington50StatesQuarters,
  washingtonDCUSTerritoriesQuarters,
  washingtonAmericaTheBeautifulQuarters,

  // half dollars
  flowingHairHalfDollar,
  drapedBustHalfDollar,
  cappedBustHalfDollar,
  libertySeatedHalfDollar,
  barberHalfDollar,
  walkingLibertyHalfDollar,
  franklinHalfDollar,
  kennedyHalfDollar,

  // dollars
  flowingHairDollar,
  morganDollar
}

extension CoinTypeExtension on CoinType {
  String toPath() {
    final enumString = this.toString();
    return enumString.substring(enumString.indexOf('.') + 1);
  }
}

CoinType? coinTypeFromString(String type) {
  final typeString = type.toLowerCase().replaceAll(' ', '');
  for (var typeEnum in CoinType.values) {
    if (typeEnum
            .toString()
            .substring(typeEnum.toString().indexOf('.') + 1)
            .toLowerCase() ==
        typeString) {
      return typeEnum;
    }
  }
  return null;
}

bool validCoinType(String type) {
  return coinTypeFromString(type) != null;
}
