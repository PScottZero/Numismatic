package com.pscottzero.service

import com.pscottzero.config.LocalCoinData
import com.pscottzero.model.*
import com.pscottzero.util.CoinVariantTranslator
import com.pscottzero.util.Logger
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import it.skrape.selects.ElementNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.context.event.ApplicationReadyEvent
import org.springframework.boot.context.event.ApplicationStartedEvent
import org.springframework.context.event.EventListener
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.lang.Exception

@Service
class CoinDataService: Logger() {
    @Autowired
    private lateinit var localCoinData: LocalCoinData

    @Autowired
    private lateinit var coinPriceCacheService: CoinPriceCacheService

    @EventListener(ApplicationReadyEvent::class)
    fun initCoinPrices() {
        coinPriceCacheService.refreshCoinPrices()
    }

    fun getRetailPrice(coinDataRequest: CoinDataRequest): String {
        val greysheetType = CoinType.fromString(coinDataRequest.type)?.greysheetType() ?: ""
        val greysheetVariants = CoinVariantTranslator.dataRequestToGreysheetVariants(coinDataRequest) ?: Pair("", "")
        val grade = coinDataRequest.grade?.replace("-", "") ?: ""
        return getRetailPrice(greysheetType, greysheetVariants, grade)
    }

    fun getRetailPrice(coin: GreysheetDataRequest): String {
        return getRetailPrice(coin.type, Pair(coin.variant, ""), coin.grade ?: "")
    }

    private fun getRetailPrice(type: String, variants: Pair<String, String>, grade: String): String {
        var price = coinPriceCacheService.coinPriceCache.read(type, variants, grade)
        if (price == null) price = try {
            val priceUrl = localCoinData.getPriceUrl(type, variants)
            if (priceUrl != null) {
                skrape(HttpFetcher) {
                    request { url = "https://www.greysheet.com/$priceUrl" }
                    response {
                        htmlDocument {
                            try {
                                findAll("div.panel-body") {
                                    try {
                                        val grades = findAll("p.entry-title").map { it.text }
                                        val prices = findAll("button.button-cpg-value").map { it.text }
                                        val priceIndex = grades.indexOf(grade.replace("-", ""))
                                        if (priceIndex >= 0) {
                                            prices[priceIndex].replace("CPG: ", "").replace(" ", "")
                                        } else {
                                            "Could not find grade $grade"
                                        }
                                    } catch (ex: ElementNotFoundException) {
                                        "No price available"
                                    }
                                }
                            } catch (ex: ElementNotFoundException) {
                                "No price available"
                            }
                        }
                    }
                }
            } else {
                return "No price available"
            }
        } catch (ex: Exception) {
            return "Error loading price data"
        }
        return price ?: "Error loading price data"
    }

    fun getMintage(mintageRequest: CoinDataRequest): String {
        return localCoinData.getMintage(mintageRequest) ?: "Mintage not available"
    }

    fun getMintage(coin: GreysheetDataRequest): String {
        return localCoinData.getMintage(coin) ?: "Mintage not available"
    }
}
