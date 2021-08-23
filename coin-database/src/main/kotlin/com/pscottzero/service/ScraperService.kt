package com.pscottzero.service

import com.google.gson.GsonBuilder
import com.pscottzero.model.GreysheetData
import com.pscottzero.model.CoinType
import com.pscottzero.util.Logger
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import it.skrape.selects.ElementNotFoundException
import org.springframework.stereotype.Service
import java.io.File

@Service
class ScraperService: Logger() {
    private val gson = GsonBuilder().setPrettyPrinting().create()

    fun scrapeCoinPriceLinks() {
        val coinLinks: MutableMap<String, MutableMap<String, GreysheetData>> = mutableMapOf()
        val coinTypes = skrape(HttpFetcher) {
            request { url = "https://www.greysheet.com/coin-prices" }
            response {
                htmlDocument {
                    eachLink.filter { it.value.contains("/coin-prices/series-landing/") }
                }
            }
        }
        coinTypes.forEach { coinType ->
            try {
                val coinEntries = skrape(HttpFetcher) {
                    request { url = "https://www.greysheet.com/${coinType.value}" }
                    response {
                        htmlDocument {
                            findAll("div.regular-coin-box").map {
                                val entryTitle = it.findFirst("p.entry-title")
                                val name = entryTitle.text
                                val link = entryTitle.eachHref[0]
                                val mintage = try {
                                    it.findFirst("p.series-details-text") {
                                        text.replace("Mintage: ", "")
                                    }
                                } catch (ex: ElementNotFoundException) {
                                    null
                                }
                                Pair(name, GreysheetData(link, mintage))
                            }
                        }
                    }
                }
                coinEntries.forEach { coinEntry ->
                    info("Adding variant link for coin: ${coinType.key} ${coinEntry.first}")
                    if (coinLinks[coinType.key] == null) coinLinks[coinType.key] = mutableMapOf()
                    coinLinks[coinType.key]!![coinEntry.first] = coinEntry.second
                }
            } catch (ex: Exception) {
                error("Could not get variant links for coin type: ${coinType.key}")
            }
        }
        File("coin-links-and-mintage.json").bufferedWriter().use {
            it.write(gson.toJson(coinLinks))
        }
    }
}