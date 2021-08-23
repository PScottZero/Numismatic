package com.pscottzero.config

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.pscottzero.model.CoinDataRequest
import com.pscottzero.model.CoinType
import com.pscottzero.model.GreysheetData
import com.pscottzero.model.GreysheetDataRequest
import com.pscottzero.util.CoinVariantTranslator
import org.springframework.context.annotation.Configuration

@Configuration
open class LocalCoinData {
    val localCoinData: Map<String, Map<String, GreysheetData>> = Gson().fromJson(
        javaClass.getResource("/coin-links-and-mintage.json")?.readText() ?: "{}",
        object : TypeToken<Map<String, Map<String, GreysheetData>>>() {}.type
    )

    fun getPriceUrl(type: String, variants: Pair<String, String>): String? {
        val url = localCoinData[type]?.get(variants.first)?.url
        if (url == null) localCoinData[type]?.get(variants.second)?.url
        return url
    }

    fun getMintage(dataRequest: CoinDataRequest): String? {
        return getGreysheetDataFromDataRequest(dataRequest)?.mintage
    }

    fun getMintage(coin: GreysheetDataRequest): String? {
        return localCoinData[coin.type]?.get(coin.variant)?.mintage
    }

    private fun getGreysheetDataFromDataRequest(dataRequest: CoinDataRequest): GreysheetData? {
        val greysheetType = CoinType.fromString(dataRequest.type)?.greysheetType()
        if (greysheetType != null) {
            val variantPair = CoinVariantTranslator.dataRequestToGreysheetVariants(dataRequest)
            if (variantPair != null) {
                var coinData = try {
                    localCoinData[greysheetType]?.filter {
                        it.key.lowercase().contains(variantPair.first.lowercase())
                    }?.iterator()?.next()?.value
                } catch (ex: NoSuchElementException) {
                    null
                }
                if (coinData == null) coinData = try {
                    localCoinData[greysheetType]?.filter {
                        it.key.lowercase().contains(variantPair.first.lowercase())
                    }?.iterator()?.next()?.value
                } catch (ex: NoSuchElementException) {
                    null
                }
                return coinData
            }
        }
        return null
    }
}