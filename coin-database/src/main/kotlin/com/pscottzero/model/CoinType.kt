package com.pscottzero.model

enum class CoinType(
    private val greysheetType: String? = null,
    val photogradeType: String? = null,
    private val cachePrice: Boolean = true
) {
    // half cents
    LIBERTY_CAP_HALF_CENT(photogradeType = "1793HalfCent"),
    DRAPED_BUST_HALF_CENT(photogradeType = "DrapedHalfCent"),
    CLASSIC_HEAD_HALF_CENT(photogradeType = "ClassicHalfCent"),
    BRAIDED_HAIR_HALF_CENT(photogradeType = "BraidedHalfCent"),

    // large cents
    CHAIN_CENT(
        greysheetType = "Flowing Hair Large Cents",
        photogradeType = "ChainCent",
        cachePrice = false
    ),
    WREATH_CENT(
        greysheetType = "Flowing Hair Large Cents",
        photogradeType = "WreathCent",
        cachePrice = false
    ),
    LIBERTY_CAP_LARGE_CENT(
        greysheetType = "Flowing Hair Large Cents",
        photogradeType = "LibertyCapCent"
    ),
    DRAPED_BUST_LARGE_CENT(photogradeType = "DrapedBustCent"),
    CLASSIC_HEAD_LARGE_CENT(photogradeType = "ClassicCent"),
    CORONET_HEAD_LARGE_CENT(photogradeType = "CoronetCent"),
    BRAIDED_HAIR_LARGE_CENT(photogradeType = "BraidedCent"),

    // small cents
    FLYING_EAGLE_CENT(photogradeType = "Flying"),
    INDIAN_CENT(photogradeType = "Indian"),
    LINCOLN_CENT_WHEAT_REVERSE(
        greysheetType = "Lincoln Cents - Wheat Reverse",
        photogradeType = "Lincoln"
    ),
    LINCOLN_CENT_MEMORIAL_REVERSE(greysheetType = "Lincoln Cents - Memorial Reverse"),

    // two cent pieces
    TWO_CENT_PIECE(
        greysheetType = "2-Cent Pieces",
        photogradeType = "TwoCent"
    ),

    // three cent pieces
    THREE_CENT_SILVER(
        greysheetType = "3-Cent Silver",
        photogradeType = "3CentSil"
    ),
    THREE_CENT_NICKEL(
        greysheetType = "3-cent Nickels",
        photogradeType = "3CentNic"
    ),

    // nickels
    SHIELD_NICKEL(photogradeType = "ShieldNic"),
    LIBERTY_NICKEL(
        greysheetType = "V-Nickels",
        photogradeType = "LibNic"
    ),
    BUFFALO_NICKEL(photogradeType = "Buffalo"),
    JEFFERSON_NICKEL(photogradeType = "Jefferson"),

    // half dimes
    FLOWING_HAIR_HALF_DIME(photogradeType = "FlowingHalfDime"),
    DRAPED_BUST_HALF_DIME_SMALL_EAGLE(
        greysheetType = "Draped Bust Half Dimes",
        photogradeType = "DrapedHalfDime"
    ),
    DRAPED_BUST_HALF_DIME_LARGE_EAGLE(
        greysheetType = "Draped Bust Half Dimes",
        photogradeType = "DrapedHalfDimeLE",
        cachePrice = false
    ),
    CAPPED_BUST_HALF_DIME(photogradeType = "CappedHalfDime"),
    LIBERTY_SEATED_HALF_DIME(photogradeType = "Seated-Half-Dime"),

    // dimes
    DRAPED_BUST_DIME_SMALL_EAGLE(
        greysheetType = "Draped Bust Dimes",
        photogradeType = "Draped10SE"
    ),
    DRAPED_BUST_DIME_LARGE_EAGLE(
        greysheetType = "Draped Bust Dimes",
        photogradeType = "Draped10LE",
        cachePrice = false
    ),
    CAPPED_BUST_DIME(photogradeType = "Capped10Lg"),
    LIBERTY_SEATED_DIME(photogradeType = "Seated10"),
    BARBER_DIME(photogradeType = "Barber10"),
    MERCURY_DIME(photogradeType = "Mercury"),
    ROOSEVELT_DIME(photogradeType = "Roosevelt"),

    // twenty cents
    TWENTY_CENT_PIECE(
        greysheetType = "20-Cent Pieces",
        photogradeType = "Twenty"
    ),

    // quarters
    DRAPED_BUST_QUARTER_SMALL_EAGLE(
        greysheetType = "Draped Bust Quarters",
        photogradeType = "Draped25SE"
    ),
    DRAPED_BUST_QUARTER_LARGE_EAGLE(
        greysheetType = "Draped Bust Quarters",
        photogradeType = "Draped25LE",
        cachePrice = false
    ),
    CAPPED_BUST_QUARTER(photogradeType = "Capped25Lg"),
    LIBERTY_SEATED_QUARTER(photogradeType = "Seated25"),
    BARBER_QUARTER(photogradeType = "Barber25"),
    STANDING_LIBERTY_QUARTER(photogradeType = "SLQT1"),
    WASHINGTON_QUARTER(
        greysheetType = "Washington Quarters (1932-98)",
        photogradeType = "Washington"
    ),

    // half dollars
    FLOWING_HAIR_HALF_DOLLAR(photogradeType = "FlowingHalf"),
    DRAPED_BUST_HALF_DOLLAR_SMALL_EAGLE(
        greysheetType = "Draped Bust Half Dollars",
        photogradeType = "Draped50SE"
    ),
    DRAPED_BUST_HALF_DOLLAR_LARGE_EAGLE(
        greysheetType = "Draped Bust Half Dollars",
        photogradeType = "Draped50LE",
        cachePrice = false
    ),
    CAPPED_BUST_HALF_DOLLAR(photogradeType = "Capped50"),
    LIBERTY_SEATED_HALF_DOLLAR(photogradeType = "Seated50"),
    BARBER_HALF_DOLLAR(
        greysheetType = "Barber Halves",
        photogradeType = "Barber50"
    ),
    WALKING_LIBERTY_HALF_DOLLAR(
        greysheetType = "Walking Liberty Halves",
        photogradeType = "Walker"
    ),
    FRANKLIN_HALF_DOLLAR(
        greysheetType = "Franklin Halves",
        photogradeType = "Franklin"
    ),
    KENNEDY_HALF_DOLLAR(
        greysheetType = "Kennedy Halves",
        photogradeType = "Kennedy"
    ),

    // dollars
    FLOWING_HAIR_DOLLAR(photogradeType = "FlowingDol"),
    DRAPED_BUST_DOLLAR_SMALL_EAGLE(
        greysheetType = "Draped Bust Dollars",
        photogradeType = "DrapedDolLE"
    ),
    DRAPED_BUST_DOLLAR_LARGE_EAGLE(
        greysheetType = "Draped Bust Dollars",
        photogradeType = "DrapedDolLE",
        cachePrice = false
    ),
    LIBERTY_SEATED_DOLLAR(
        greysheetType = "Seated Dollars",
        photogradeType = "SeatedDol"
    ),
    TRADE_DOLLAR(photogradeType = "Trade"),
    MORGAN_DOLLAR(photogradeType = "Morgan"),
    PEACE_DOLLAR(photogradeType = "Peace"),
    EISENHOWER_DOLLAR(photogradeType = "Ike"),
    SUSAN_B_ANTHONY_DOLLAR(
        greysheetType = "Susan B. Anthony Dollars",
        photogradeType = "SBA"
    ),
    SACAGAWEA_DOLLAR(
        greysheetType = "Sacagawea & Native American Dollars (2000-Present)",
        photogradeType = "SAC"
    ),
    ONE_DOLLAR_GOLD_TYPE_1(
        greysheetType = "$1 Gold - Type 1",
        photogradeType = "GoldDollar1"
    ),
    ONE_DOLLAR_GOLD_TYPE_2(
        greysheetType = "$1 Gold - Type 2",
        photogradeType = "GoldDollar2"
    ),
    ONE_DOLLAR_GOLD_TYPE_3(
        greysheetType = "$1 Gold - Type 3",
        photogradeType = "GoldDollar3"
    ),

    // quarter eagles
    DRAPED_BUST_QUARTER_EAGLE(
        greysheetType = "$2.50 Draped Bust Gold",
        photogradeType = "DrapedBustR2.5LE"
    ),
    CAPPED_BUST_QUARTER_EAGLE(
        greysheetType = "$2.50 Capped Bust Gold",
        photogradeType = "Capped2.5"
    ),
    CLASSIC_HEAD_QUARTER_EAGLE(
        greysheetType = "$2.50 Classic Head Gold",
        photogradeType = "Classic2.5"
    ),
    LIBERTY_HEAD_QUARTER_EAGLE(
        greysheetType = "$2.50 Liberty Gold",
        photogradeType = "2.5Lib"
    ),
    INDIAN_HEAD_QUARTER_EAGLE(
        greysheetType = "$2.50 Indian Gold",
        photogradeType = "2.5Ind"
    ),

    // three dollars
    PRINCESS_HEAD_THREE_DOLLARS(
        greysheetType = "$3 Princess Head Gold",
        photogradeType = "3Gold"
    ),

    // half eagles
    DRAPED_BUST_HALF_EAGLE_SMALL_EAGLE(
        greysheetType = "$5 Draped Bust Gold",
        photogradeType = "DrapedBust5SE"
    ),
    DRAPED_BUST_HALF_EAGLE_LARGE_EAGLE(
        greysheetType = "$5 Draped Bust Gold",
        photogradeType = "DrapedBust5LE",
        cachePrice = false
    ),
    CAPPED_BUST_HALF_EAGLE(
        greysheetType = "$5 Capped Bust Gold",
        photogradeType = "CappedBust5"
    ),
    CAPPED_HEAD_HALF_EAGLE(
        greysheetType = "$5 Capped Bust Gold",
        photogradeType = "CappedHead5",
        cachePrice = false
    ),
    CLASSIC_HEAD_HALF_EAGLE(
        greysheetType = "$5 Classic Head Gold",
        photogradeType = "CappedHead5"
    ),
    LIBERTY_HEAD_HALF_EAGLE(
        greysheetType = "$5 Liberty Gold",
        photogradeType = "5Lib"
    ),
    INDIAN_HEAD_HALF_EAGLE(
        greysheetType = "$5 Indian Gold",
        photogradeType = "5Ind"
    ),

    // eagles
    DRAPED_BUST_EAGLE_SMALL_EAGLE(
        greysheetType = "$10 Draped Bust Gold",
        photogradeType = "DrapedBust10SE"
    ),
    DRAPED_BUST_EAGLE_LARGE_EAGLE(
        greysheetType = "$10 Draped Bust Gold",
        photogradeType = "DrapedBust10LE",
        cachePrice = false
    ),
    CAPPED_BUST_EAGLE(greysheetType = "$10 Capped Bust Gold"),
    CLASSIC_HEAD_EAGLE(greysheetType = "$10 Classic Head Gold"),
    LIBERTY_HEAD_EAGLE(
        greysheetType = "$10 Liberty Gold",
        photogradeType = "10Lib"
    ),
    INDIAN_HEAD_EAGLE(
        greysheetType = "$10 Indian Gold",
        photogradeType = "10Ind"
    ),

    // double eagles
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_1(
        greysheetType = "$20 Liberty Gold - Type 1",
        photogradeType = "20Lib"
    ),
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_2(
        greysheetType = "$20 Liberty Gold - Type 2",
        photogradeType = "20Lib"
    ),
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_3(
        greysheetType = "$20 Liberty Gold - Type 3",
        photogradeType = "20Lib"
    ),
    SAINT_GAUDENS_DOUBLE_EAGLE(
        greysheetType = "$20 Saint Gaudens Gold",
        photogradeType = "20Saint"
    ),

    // bullion
    SILVER_EAGLE(
        greysheetType = "$1-silver-eagles",
        photogradeType = "SilEag"
    ),
    GOLD_EAGLE_FIVE_DOLLARS(
        greysheetType = "$5-gold-eagles",
        photogradeType = "GldEag"
    ),
    GOLD_EAGLE_TEN_DOLLARS(
        greysheetType = "$10-gold-eagles",
        photogradeType = "GldEag"
    ),
    GOLD_EAGLE_TWENTY_FIVE_DOLLARS(
        greysheetType = "$25-gold-eagles",
        photogradeType = "GldEag"
    ),
    GOLD_EAGLE_FIFTY_DOLLARS(
        greysheetType = "$50-gold-eagles",
        photogradeType = "GldEag"
    );

    override fun toString(): String {
        return super.toString().lowercase().split("_")
            .joinToString(" ") { it.replaceFirstChar { char -> char.uppercase() } }
    }

    fun greysheetType(): String {
        return this.greysheetType ?: "${this}s"
    }

    companion object {
        fun fromString(type: String): CoinType? {
            values().forEach {
                if (it.toString() == type) return it
            }
            return null
        }
    }
}
