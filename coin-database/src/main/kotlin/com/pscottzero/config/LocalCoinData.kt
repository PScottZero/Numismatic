package com.pscottzero.config

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.pscottzero.model.CoinType
import com.pscottzero.model.GreysheetData
import com.pscottzero.model.GreysheetMintageRequest
import com.pscottzero.model.MintageRequest
import com.pscottzero.util.RequestToVariants
import org.springframework.context.annotation.Configuration

@Configuration
open class LocalCoinData {
    private val localCoinData: Map<String, Map<String, GreysheetData>> = Gson().fromJson(
        javaClass.getResource("/coin-links-and-mintage.json")?.readText() ?: "{}",
        object : TypeToken<Map<String, Map<String, GreysheetData>>>() {}.type
    )

    fun getPriceUrl(type: String, variants: Pair<String, String>): Pair<String?, String?> {
        val url = localCoinData[type]?.get(variants.first)?.url
        var variant = variants.first
        if (url == null) {
            localCoinData[type]?.get(variants.second)?.url
            variant = variants.second
        }
        return Pair(url, variant)
    }

    fun getMintage(mintageRequest: MintageRequest): String? {
        val greysheetType = CoinType.fromString(mintageRequest.type)?.greysheetType()
        if (greysheetType != null) {
            val variantPair = RequestToVariants.mintageRequestToGreysheetVariants(mintageRequest)
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
                return coinData?.mintage
            }
        }
        return null
    }

    fun getMintage(greysheetMintageRequest: GreysheetMintageRequest): String? {
        return localCoinData[greysheetMintageRequest.type]?.get(greysheetMintageRequest.variant)?.mintage
    }
}