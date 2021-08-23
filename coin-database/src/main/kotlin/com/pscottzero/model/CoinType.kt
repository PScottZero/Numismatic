package com.pscottzero.model

enum class CoinType(
    private val type: String? = null
) {
    // half cents
    LIBERTY_CAP_HALF_CENT,
    DRAPED_BUST_HALF_CENT,
    CLASSIC_HEAD_HALF_CENT,
    BRAIDED_HAIR_HALF_CENT,

    // large cents
    FLOWING_HAIR_LARGE_CENT,
    DRAPED_BUST_LARGE_CENT,
    CLASSIC_HEAD_LARGE_CENT,
    CORONET_HEAD_LARGE_CENT,
    BRAIDED_HAIR_LARGE_CENT,

    // small cents
    FLYING_EAGLE_CENT,
    INDIAN_CENT,
    LINCOLN_CENT_WHEAT_REVERSE(type = "Lincoln Cents - Wheat Reverse"),
    // LINCOLN_CENT_MEMORIAL_REVERSE(type = "Lincoln Cents - Memorial Reverse"),

    // two cent pieces
    TWO_CENT_PIECE(type = "2-Cent Pieces"),

    // three cent pieces
    THREE_CENT_SILVER(type = "3-Cent Silver"),
    THREE_CENT_NICKEL(type = "3-cent Nickels"),

    // nickels
    SHIELD_NICKEL,
    V_NICKEL(type = "V-Nickels"),
    BUFFALO_NICKEL,
    // JEFFERSON_NICKEL,

    // half dimes
    FLOWING_HAIR_HALF_DIME,
    DRAPED_BUST_HALF_DIME,
    CAPPED_BUST_HALF_DIME,
    LIBERTY_SEATED_HALF_DIME,

    // dimes
    DRAPED_BUST_DIME,
    CAPPED_BUST_DIME,
    LIBERTY_SEATED_DIME,
    BARBER_DIME,
    MERCURY_DIME,
    // ROOSEVELT_DIME,

    // twenty cents
    TWENTY_CENT_PIECE(type = "20-Cent Pieces"),

    // quarters
    DRAPED_BUST_QUARTER,
    CAPPED_BUST_QUARTER,
    LIBERTY_SEATED_QUARTER,
    BARBER_QUARTER,
    STANDING_LIBERTY_QUARTER,
    // WASHINGTON_QUARTER(type = "Washington Quarters (1932-98)"),

    // half dollars
    FLOWING_HAIR_HALF_DOLLAR,
    DRAPED_BUST_HALF_DOLLAR,
    CAPPED_BUST_HALF_DOLLAR,
    LIBERTY_SEATED_HALF_DOLLAR,
    BARBER_HALF_DOLLAR(type = "Barber Halves"),
    WALKING_LIBERTY_HALF_DOLLAR(type = "Walking Liberty Halves"),
    FRANKLIN_HALF_DOLLAR(type = "Franklin Halves"),
    // KENNEDY_HALF_DOLLAR(type = "Kennedy Halves"),

    // dollars
    FLOWING_HAIR_DOLLAR,
    DRAPED_BUST_DOLLAR,
    GOBRECHT_DOLLAR,
    LIBERTY_SEATED_DOLLAR(type = "Seated Dollars"),
    TRADE_DOLLAR,
    MORGAN_DOLLAR,
    PEACE_DOLLAR,
    // EISENHOWER_DOLLAR,
    // SUSAN_B_ANTHONY_DOLLAR(type = "Susan B. Anthony Dollars"),
    // SACAGAWEA_DOLLAR(type = "Sacagawea & Native American Dollars (2000-Present)"),
    ONE_DOLLAR_GOLD_TYPE_1(type = "$1 Gold - Type 1"),
    ONE_DOLLAR_GOLD_TYPE_2(type = "$1 Gold - Type 2"),
    ONE_DOLLAR_GOLD_TYPE_3(type = "$1 Gold - Type 3"),

    // quarter eagles
    DRAPED_BUST_QUARTER_EAGLE(type = "$2.50 Draped Bust Gold"),
    CAPPED_BUST_QUARTER_EAGLE(type = "$2.50 Capped Bust Gold"),
    CLASSIC_HEAD_QUARTER_EAGLE(type = "$2.50 Classic Head Gold"),
    LIBERTY_HEAD_QUARTER_EAGLE(type = "$2.50 Liberty Gold"),
    INDIAN_HEAD_QUARTER_EAGLE(type = "$2.50 Indian Gold"),

    // three dollars
    PRINCESS_HEAD_THREE_DOLLARS(type = "$3 Princess Head Gold"),

    // half eagles
    DRAPED_BUST_HALF_EAGLE(type = "$5 Draped Bust Gold"),
    CAPPED_BUST_HALF_EAGLE(type = "$5 Capped Bust Gold"),
    CLASSIC_HEAD_HALF_EAGLE(type = "$5 Classic Head Gold"),
    LIBERTY_HEAD_HALF_EAGLE(type = "$5 Liberty Gold"),
    INDIAN_HEAD_HALF_EAGLE(type = "$5 Indian Gold"),

    // eagles
    DRAPED_BUST_EAGLE(type = "$10 Draped Bust Gold"),
    CAPPED_BUST_EAGLE(type = "$10 Capped Bust Gold"),
    CLASSIC_HEAD_EAGLE(type = "$10 Classic Head Gold"),
    LIBERTY_HEAD_EAGLE(type = "$10 Liberty Gold"),
    INDIAN_HEAD_EAGLE(type = "$10 Indian Gold"),

    // double eagles
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_1(type = "$20 Liberty Gold - Type 1"),
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_2(type = "$20 Liberty Gold - Type 2"),
    LIBERTY_HEAD_DOUBLE_EAGLE_TYPE_3(type = "$20 Liberty Gold - Type 3"),
    SAINT_GAUDENS_DOUBLE_EAGLE(type = "$20 Saint Gaudens Gold");

    override fun toString(): String {
        return super.toString().lowercase().split("_")
            .joinToString(" ") { it.replaceFirstChar { char -> char.uppercase() } }
    }

    fun greysheetType(): String {
        return this.type ?: "${this}s"
    }

    companion object {
        fun fromString(type: String): CoinType? {
            values().forEach {
                if (it.toString() == type) return it
            }
            return null
        }

        fun fromGreysheetString(type: String): CoinType? {
            values().forEach {
                if (it.greysheetType() == type) return it
            }
            return null
        }
    }
}