package com.pscottzero.model

enum class CoinType(val withPrefix: Boolean) {
    // half-cents and cents
    LIBERTY_CAP_HALF_CENT(true),
    DRAPED_BUST_HALF_CENT(true),
    CLASSIC_HEAD_HALF_CENT(true),
    BRAIDED_HAIR_HALF_CENT(true),
    FLOWING_HAIR_LARGE_CENT(true),
    DRAPED_BUST_LARGE_CENT(true),
    CLASSIC_HEAD_LARGE_CENT(true),
    CORONET_HEAD_LARGE_CENT(true),
    BRAIDED_HAIR_LARGE_CENT(true),
    FLYING_EAGLE_CENT(false),
    INDIAN_CENT(false),
    LINCOLN_CENT_WHEAT_REVERSE(false),
    LINCOLN_CENT_MEMORIAL_REVERSE(false),

    // two and three cents
    TWO_CENT(false),


    // dollars
    MORGAN_DOLLAR(false);

    override fun toString(): String {
        return super.toString().lowercase().split("_")
            .joinToString(" ") { it.replaceFirstChar { char -> char.uppercase() } }
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