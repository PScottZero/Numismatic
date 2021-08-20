package com.pscottzero.controller

import com.pscottzero.model.CoinType
import com.pscottzero.model.CoinValueRequest
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class CoinInfoController {
    @GetMapping("/coin/types")
    @CrossOrigin(origins = ["*"])
    fun getCoinTypes(): ResponseEntity<List<String>> {
        return ResponseEntity.ok(CoinType.values().map { it.toString() })
    }

    @PostMapping("/coin/value")
    @CrossOrigin(origins = ["*"])
    fun getCoinValue(
        @RequestBody coinValueRequest: CoinValueRequest
    ): ResponseEntity<String> {
        val coinType = CoinType.fromString(coinValueRequest.type)
        if (coinType != null) {
            val coinUrl = getCoinUrl(coinValueRequest)
            val pricesMap = skrape(HttpFetcher) {
                request { url = "https://www.greysheet.com/$coinUrl" }
                response {
                    htmlDocument {
                        eachLink.filter {
                            it.value.contains("grade=${coinGradeNumber(coinValueRequest.grade)}") &&
                                    it.value.contains("cac=0")
                        }
                    }
                }
            }
            if (pricesMap.isEmpty()) {
                val mintMark = if (coinValueRequest.mintMark != null) "-${coinValueRequest.mintMark}" else ""
                return ResponseEntity.badRequest().body("Invalid coin: ${coinValueRequest.year}${mintMark} ${coinValueRequest.type}")
            }
            val filtered = pricesMap.filter {
                it.value.contains("grade=${coinGradeNumber(coinValueRequest.grade)}") &&
                        it.value.contains("cac=0")
            }
            filtered.forEach {
                if (it.key.contains("$")) {
                    return ResponseEntity.ok(it.key.substring(5).replace(" ", ""))
                }
            }
            return ResponseEntity.badRequest().body("Invalid grade: ${coinValueRequest.grade}")
        }
        return ResponseEntity.badRequest().body("Invalid coin type: ${coinValueRequest.type}")
    }

    private fun getCoinUrl(coin: CoinValueRequest): String {
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
}