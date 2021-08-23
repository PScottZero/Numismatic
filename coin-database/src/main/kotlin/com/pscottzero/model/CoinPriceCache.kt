package com.pscottzero.model

class CoinPriceCache {
    private val priceCache: MutableMap<String, MutableMap<String, MutableMap<String, String>>> = mutableMapOf()

    fun read(type: String, variants: Pair<String, String>, grade: String): String? {
        var price = priceCache[type]?.get(variants.first)?.get(grade)
        if (price == null) price = priceCache[type]?.get(variants.second)?.get(grade)
        return price
    }

    fun write(type: String, variant: String, grade: String, price: String) {
        if (priceCache[type] == null) priceCache[type] = mutableMapOf()
        if (priceCache[type]!![variant] == null) priceCache[type]!![variant] = mutableMapOf()
        priceCache[type]!![variant]!![grade] = price
    }

    fun size(): Int {
        return priceCache.toList().fold(0) { size, type ->
            size + type.second.toList().fold(0) { size1, variant ->
                size1 + variant.second.size
            }
        }
    }

    fun clear() = priceCache.clear()
}
