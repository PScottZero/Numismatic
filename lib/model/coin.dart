import 'package:json_annotation/json_annotation.dart';
import 'package:numismatic/constants/helper_functions.dart';
import 'package:numismatic/model/coin_type.dart';
import 'package:numismatic/model/reference.dart';
import 'package:uuid/uuid.dart';

import 'data_source.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  String id = const Uuid().v1().toString();
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

  static set(Coin destination, Coin source) {
    destination.type = source.type;
    destination.year = source.year;
    destination.mintMark = source.mintMark;
    destination.variation = source.variation;
    destination.mintage = source.mintage;
    destination.grade = source.grade;
    destination.retailPrice = source.retailPrice;
    destination.images = source.images;
    destination.notes = source.notes;
    destination.inCollection = source.inCollection;
    destination.imagesSource = source.imagesSource;
    destination.mintageSource = source.mintageSource;
    destination.retailPriceSource = source.retailPriceSource;
    destination.photogradeName = source.photogradeName;
    destination.photogradeGrade = source.photogradeGrade;
    destination.dateAdded = source.dateAdded;
    destination.retailPriceLastUpdated = source.retailPriceLastUpdated;
  }

  String get typeId {
    var coinType = CoinType.coinTypeFromString(type.value);
    if (coinType != null) {
      return coinType.getGreysheetName();
    } else {
      return type.value;
    }
  }

  String get fullType {
    if (hasYear()) {
      final year = variation.value.split(' ')[0];
      String? noYearVariation = variation.value.replaceAll(year, '').trim();
      if (noYearVariation == '') {
        noYearVariation = null;
      }
      return '$year ${type.value}${noYearVariation != null ? ' ($noYearVariation)' : ''}';
    } else {
      return '${type.value}${variation.valueNullable != null ? ' (${variation.value})' : ''}';
    }
  }

  double? get denomination =>
      CoinType.coinTypeFromString(type.value)?.denomination;

  hasYear() =>
      HelperFunctions.yearAndMintMarkFromVariation(variation.value).item1 !=
      null;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
