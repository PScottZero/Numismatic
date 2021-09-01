import 'package:json_annotation/json_annotation.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/model/coin_type.dart';

import 'data_source.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  String type;
  String? year;
  String? mintMark;
  String? variation;
  String? mintage;
  String? grade;
  String? retailPrice;
  List<String>? images;
  String? notes;
  bool inCollection;
  DataSource imagesSource;
  DataSource mintageSource;
  DataSource retailPriceSource;
  String? photogradeName;
  String? photogradeGrade;
  DateTime? dateAdded;
  DateTime? retailPriceLastUpdated;

  Coin({
    this.type = '',
    this.year,
    this.mintMark,
    this.variation,
    this.mintage,
    this.grade,
    this.retailPrice,
    this.images,
    this.notes,
    this.inCollection = true,
    this.imagesSource = DataSource.manual,
    this.mintageSource = DataSource.auto,
    this.retailPriceSource = DataSource.auto,
    this.photogradeName,
    this.photogradeGrade,
    this.dateAdded,
    this.retailPriceLastUpdated,
  });

  static Coin copyOf(Coin coin) {
    return Coin(
      type: coin.type,
      year: coin.year,
      mintMark: coin.mintMark,
      variation: coin.variation,
      mintage: coin.mintage,
      grade: coin.grade,
      retailPrice: coin.retailPrice,
      images: coin.images,
      notes: coin.notes,
      inCollection: coin.inCollection,
      imagesSource: coin.imagesSource,
      mintageSource: coin.mintageSource,
      retailPriceSource: coin.retailPriceSource,
      photogradeName: coin.photogradeName,
      photogradeGrade: coin.photogradeGrade,
      dateAdded: coin.dateAdded,
      retailPriceLastUpdated: coin.retailPriceLastUpdated,
    );
  }

  String? get typeId {
    var coinType = CoinType.coinTypeFromString(type);
    if (coinType != null) {
      return coinType.getGreysheetName();
    } else {
      return type;
    }
  }

  String get fullType {
    final yearAndMintMark =
        HelperFunctions.yearAndMintMarkFromVariation(variation ?? '');

    // remove year (YYYY) or year and mint mark (YYYY-MM) from variation
    final remove = yearAndMintMark?.item2 != null
        ? '${yearAndMintMark!.item1}-${yearAndMintMark.item2}'
        : yearAndMintMark?.item1 != null
            ? yearAndMintMark?.item1
            : '';
    var variationWithoutYearOrMintMark =
        variation?.replaceAll(remove!, '').trim() ?? '';
    var variationInParentheses =
        variation != null && variationWithoutYearOrMintMark.length > 2
            ? '($variationWithoutYearOrMintMark)'
            : '';
    return '${year ?? ""}${mintMark != null ? "-$mintMark" : ""} $type $variationInParentheses'
        .trim();
  }

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
