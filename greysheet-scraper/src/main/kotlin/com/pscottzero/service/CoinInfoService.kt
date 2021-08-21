package com.pscottzero.service

import com.pscottzero.model.CoinType
import com.pscottzero.model.CoinDataRequest
import com.pscottzero.model.ScraperResponse
import it.skrape.core.htmlDocument
import it.skrape.fetcher.BrowserFetcher
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import org.springframework.stereotype.Service

@Service
class CoinInfoService {
    fun getRetailValue(coinValueRequest: CoinDataRequest): ScraperResponse<String> {
        val coinType = CoinType.fromString(coinValueRequest.type)
        if (coinType != null) {
            val coinUrl = coinUrlFromLandingPage(coinValueRequest)
            val pricesMap = skrape(BrowserFetcher) {
                request { url = "https://www.greysheet.com/$coinUrl" }
                response {
                    htmlDocument {
                        eachLink.filter {
                            it.value.contains("grade=${coinGradeNumber(coinValueRequest.grade ?: "")}") &&
                                    it.value.contains("cac=0")
                        }
                    }
                }
            }
            if (pricesMap.isEmpty()) {
                val mintMark = if (coinValueRequest.mintMark != null) "-${coinValueRequest.mintMark}" else ""
                return ScraperResponse.error("Invalid coin: ${coinValueRequest.year}${mintMark} ${coinValueRequest.type}")
            }
            pricesMap.forEach {
                if (it.key.contains("$")) {
                    return ScraperResponse.success(it.key.substring(5).replace(" ", ""))
                }
            }
            return ScraperResponse.error("Invalid grade: ${coinValueRequest.grade}")
        }
        return ScraperResponse.error("Invalid coin type: ${coinValueRequest.type}")
    }

    private fun coinUrlFromLandingPage(coin: CoinDataRequest): String {
        val coinPath = prefix(CoinType.fromString(coin.type)!!) + coin.type.lowercase().replace(" ", "-") + "s"
        val links = skrape(HttpFetcher) {
            request { url = "https://www.greysheet.com/coin-prices/series-landing/$coinPath" }
            response { htmlDocument { eachLink } }
        }
        val mintMark = if (coin.mintMark != null) "-${coin.mintMark}" else ""
        return links["${coin.year}${mintMark}"] ?: ""
    }

    private fun prefix(type: CoinType): String {
        return if (type.withPrefix) "united-states-" else ""
    }

    private fun coinGradeNumber(grade: String): String {
        val gradeSplit = grade.split("-")
        return if (gradeSplit.size >= 2) grade.split("-")[1] else "0"
    }

    fun coinTypeLinks(): Map<String, String> {
        val links = skrape(BrowserFetcher) {
            request { url = "https://www.greysheet.com/coin-prices" }
            response {
                htmlDocument {
                    eachLink
                }
            }
        }
        return links.filter { it.value.contains("/coin-prices/series-landing/") }
    }
}