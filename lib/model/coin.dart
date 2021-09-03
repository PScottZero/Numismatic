import 'package:json_annotation/json_annotation.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/reference.dart';

import 'data_source.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  StringReference type = StringReference();
  String? year;
  String? mintMark;
  StringReference variation = StringReference();
  String? mintage;
  StringReference grade = StringReference();
  String? retailPrice;
  List<String>? images;
  String? notes;
  bool inCollection = true;
  DataSource imagesSource = DataSource.manual;
  DataSource mintageSource = DataSource.auto;
  DataSource retailPriceSource = DataSource.auto;
  String? photogradeName;
  String? photogradeGrade;
  DateTime? dateAdded;
  DateTime? retailPriceLastUpdated;

  Coin(
    this.type,
    this.year,
    this.mintMark,
    this.variation,
    this.mintage,
    this.grade,
    this.retailPrice,
    this.images,
    this.notes,
    this.inCollection,
    this.imagesSource,
    this.mintageSource,
    this.retailPriceSource,
    this.photogradeName,
    this.photogradeGrade,
    this.dateAdded,
    this.retailPriceLastUpdated,
  );

  Coin.empty({this.inCollection = true});

  static Coin copyOf(Coin coin) {
    return Coin(
      coin.type,
      coin.year,
      coin.mintMark,
      coin.variation,
      coin.mintage,
      coin.grade,
      coin.retailPrice,
      coin.images,
      coin.notes,
      coin.inCollection,
      coin.imagesSource,
      coin.mintageSource,
      coin.retailPriceSource,
      coin.photogradeName,
      coin.photogradeGrade,
      coin.dateAdded,
      coin.retailPriceLastUpdated,
    );
  }

  String get typeId {
    var coinType = CoinType.coinTypeFromString(type.value ?? '');
    if (coinType != null) {
      return coinType.getGreysheetName();
    } else {
      return type.value ?? '';
    }
  }

  String get fullType {
    if (hasYear()) {
      final year = variation.value?.split(' ')[0];
      final noYearVariation = variation.value?.replaceAll(year ?? '', '');
      return '$year ${type.value ?? ''} $noYearVariation';
    } else {
      return '${type.value ?? ''} ${variation.value ?? ''}';
    }
  }

  hasYear() =>
      HelperFunctions.yearAndMintMarkFromVariation(variation.value ?? '') !=
      null;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
