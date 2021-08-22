package com.pscottzero.service

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.pscottzero.model.CoinData
import com.pscottzero.model.CoinType
import com.pscottzero.model.CoinDataRequest
import com.pscottzero.util.Logger
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import it.skrape.selects.ElementNotFoundException
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.lang.Exception

@Service
@EnableScheduling
class CoinInfoService: Logger() {
    private var coinDataMap: Map<String, Map<String, CoinData>>

    private var coinPriceCache: MutableMap<CoinDataRequest, String> = mutableMapOf()

    private val gson = Gson()

    init {
        coinDataMap = gson.fromJson(
            javaClass.getResource("/coin-links-and-mintage.json")?.readText() ?: "{}",
            object : TypeToken<Map<String, Map<String, CoinData>>>() {}.type
        )
    }

    @Scheduled(fixedRate = 3600000, initialDelay = 3600000)
    fun clearPriceCache() {
        coinPriceCache.clear()
        info("Cleared coin price cache")
    }

    fun getRetailPrice(priceRequest: CoinDataRequest): String {
        if (coinPriceCache[priceRequest] != null) {
            info("Found coin price in cache")
            return coinPriceCache[priceRequest]!!
        }
        val priceUrl = getCoinData(priceRequest)?.link
        if (priceUrl != null) {
            return try {
                skrape(HttpFetcher) {
                    request { url = "https://www.greysheet.com/$priceUrl" }
                    response {
                        htmlDocument {
                            try {
                                findAll("div.panel-body") {
                                    try {
                                        val grades = findAll("p.entry-title").map { it.text }
                                        val prices = findAll("button.button-cpg-value").map { it.text }
                                        val priceIndex = grades.indexOf(priceRequest.grade.replace("-", ""))
                                        if (priceIndex >= 0) {
                                            val price = prices[priceIndex].replace("CPG: ", "").replace(" ", "")
                                            coinPriceCache[priceRequest] = price
                                            price
                                        } else {
                                            "Could not find grade ${priceRequest.grade}"
                                        }
                                    } catch (ex: ElementNotFoundException) {
                                        "No price data available"
                                    }
                                }
                            } catch (ex: ElementNotFoundException) {
                                "No price data available"
                            }
                        }
                    }
                }
            } catch (ex: Exception) {
                "Error loading price data"
            }
        }
        return "No price data available"
    }

    fun getMintage(mintageRequest: CoinDataRequest): String {
        return getCoinData(mintageRequest)?.mintage ?: "Mintage not available"
    }

    private fun getCoinData(dataRequest: CoinDataRequest): CoinData? {
        val type = CoinType.fromString(dataRequest.type)
        if (type != null) {
            val mintMark = if (dataRequest.mintMark != null) "-${dataRequest.mintMark}" else ""
            val gradeSplit = dataRequest.grade.split("-")
            val greensheetType = if (gradeSplit[0] == "PR") type.greensheetProof() else type.greensheetType()
            val details = "${dataRequest.details ?: ""} ${if (gradeSplit.size >= 3) gradeSplit[2] else ""}".trim()
            val variantNoComma = "${dataRequest.year}${mintMark} $details".trim()
            val variantWithComma = "${dataRequest.year}${mintMark}, $details"
            var coinData = try {
                coinDataMap[greensheetType]?.filter {
                    it.key.lowercase().contains(variantNoComma.lowercase())
                }?.iterator()?.next()?.value
            } catch (ex: NoSuchElementException) {
                null
            }
            if (coinData == null) coinData = try {
                coinDataMap[greensheetType]?.filter {
                    it.key.lowercase().contains(variantWithComma.lowercase())
                }?.iterator()?.next()?.value
            } catch (ex: NoSuchElementException) {
                null
            }
            return coinData
        }
        return null
    }
}
