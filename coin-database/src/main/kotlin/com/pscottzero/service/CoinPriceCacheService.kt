package com.pscottzero.service

import com.pscottzero.config.LocalCoinData
import com.pscottzero.model.CoinPriceCache
import com.pscottzero.model.CoinType
import com.pscottzero.util.Logger
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import it.skrape.selects.ElementNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.lang.Exception
import kotlin.system.measureTimeMillis

@Service
class CoinPriceCacheService: Logger() {
    @Autowired
    lateinit var localCoinData: LocalCoinData

    var coinPriceCache = CoinPriceCache()

    var cacheIsRefreshing: Boolean = false

    companion object {
        const val EVERY_MONDAY_AT_MIDNIGHT = "0 0 0 * * MON"
    }

    fun refreshCache(): String {
        return if (!cacheIsRefreshing) {
            refreshCoinPrices()
        } else {
            "Cache is currently refreshing"
        }
    }

    @Scheduled(cron = EVERY_MONDAY_AT_MIDNIGHT)
    fun refreshCoinPrices(): String {
        if (!cacheIsRefreshing) {
            cacheIsRefreshing = true
            coinPriceCache.clear()
            val ms = measureTimeMillis {
                localCoinData.localCoinData.forEach { typeMap ->
                    val type = typeMap.key
                    if (CoinType.fromGreysheetString(type) != null) {
                        typeMap.value.forEach { variantMap ->
                            val variant = variantMap.key
                            val greysheetData = variantMap.value
                            info("Getting prices for coin: $type $variant")
                            try {
                                skrape(HttpFetcher) {
                                    request { url = "https://www.greysheet.com/${greysheetData.url}" }
                                    response {
                                        htmlDocument {
                                            try {
                                                findAll("div.panel-body") {
                                                    try {
                                                        val grades = findAll("p.entry-title").map { it.text }
                                                        val prices = findAll("button.button-cpg-value").map { it.text }
                                                        if (grades.size == prices.size) {
                                                            grades.forEachIndexed { index, grade ->
                                                                val price =
                                                                    prices[index].replace("CPG: ", "").replace(" ", "")
                                                                coinPriceCache.write(type, variant, grade, price)
                                                            }
                                                            info("Retrieved prices for coin: $type $variant")
                                                        } else {
                                                            error("Grade and price count do not match for coin: $type $variant")
                                                        }
                                                    } catch (ex: ElementNotFoundException) {
                                                        error("No price data available for coin: $type $variant")
                                                    }
                                                }
                                            } catch (ex: ElementNotFoundException) {
                                                error("No price data available for coin: $type $variant")
                                            }
                                        }
                                    }
                                }
                            } catch (ex: Exception) {
                                error("Scraper threw exception: $ex ${ex.message}")
                            }
                        }
                    }
                }
            }
            cacheIsRefreshing = false
            val totalSeconds = ms / 1000
            val minutes = totalSeconds / 60
            val seconds = totalSeconds % 60
            info("Completed refreshing coin prices in ${minutes}m ${seconds}s")
            return "Completed refreshing coin prices in ${minutes}m ${seconds}s"
        }
        return "Cache is currently refreshing"
    }
}