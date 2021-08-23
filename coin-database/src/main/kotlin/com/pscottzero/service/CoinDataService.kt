package com.pscottzero.service

import com.pscottzero.config.LocalCoinData
import com.pscottzero.model.*
import com.pscottzero.util.RequestToVariants
import com.pscottzero.util.Logger
import it.skrape.core.htmlDocument
import it.skrape.fetcher.HttpFetcher
import it.skrape.fetcher.response
import it.skrape.fetcher.skrape
import it.skrape.selects.ElementNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.awt.image.BufferedImage
import java.io.ByteArrayOutputStream
import java.net.URL
import javax.imageio.ImageIO

@Service
@EnableScheduling
class CoinDataService: Logger() {
    @Autowired
    private lateinit var localCoinData: LocalCoinData

    private var coinPriceCache = CoinPriceCache()

    @Scheduled(cron = "0 0 0 * * MON")
    fun clearCache() = coinPriceCache.clear()

    fun getRetailPrice(priceRequest: PriceRequest): String {
        val greysheetType = CoinType.fromString(priceRequest.type)?.greysheetType() ?: ""
        val greysheetVariants = RequestToVariants.priceRequestToGreysheetVariants(priceRequest) ?: Pair("", "")
        val grade = priceRequest.grade.replace("-", "")
        return getRetailPrice(greysheetType, greysheetVariants, grade)
    }

    fun getRetailPrice(greysheetPriceRequest: GreysheetPriceRequest): String {
        return getRetailPrice(
            greysheetPriceRequest.type,
            Pair(greysheetPriceRequest.variant, ""),
            greysheetPriceRequest.grade
        )
    }

    private fun getRetailPrice(type: String, variants: Pair<String, String>, grade: String): String {
        var price = coinPriceCache.read(type, variants, grade)
        if (price == null) price = try {
            val priceUrlPair = localCoinData.getPriceUrl(type, variants)
            if (priceUrlPair.first != null) {
                skrape(HttpFetcher) {
                    request { url = "https://www.greysheet.com/${priceUrlPair.first}" }
                    response {
                        htmlDocument {
                            try {
                                findAll("div.panel-body") {
                                    try {
                                        val grades = findAll("p.entry-title").map { it.text }
                                        val prices = findAll("button.button-cpg-value").map { it.text }
                                        val priceIndex = grades.indexOf(grade.replace("-", ""))
                                        if (priceIndex >= 0) {
                                            val coinPrice = prices[priceIndex].replace("CPG: ", "").replace(" ", "")
                                            coinPriceCache.write(type, priceUrlPair.second!!, grade, coinPrice)
                                            coinPrice
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

    fun getMintage(mintageRequest: MintageRequest): String {
        return localCoinData.getMintage(mintageRequest) ?: "Mintage not available"
    }

    fun getMintage(greysheetMintageRequest: GreysheetMintageRequest): String {
        return localCoinData.getMintage(greysheetMintageRequest) ?: "Mintage not available"
    }

    fun getPhoto(photogradeRequest: PCGSPhotogradeRequest, side: CoinSide): ByteArray {
        val photogradeType = CoinType.fromString(photogradeRequest.type)?.photogradeType ?: photogradeRequest.type
        val gradeSplit = photogradeRequest.grade.split("-")
        val grade = if (gradeSplit.size >= 2) gradeSplit[1] else photogradeRequest.grade
        return try {
            val url = URL("https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeType-${grade}${side.sideChar}.jpg")
            return bufferedImageToByteArray(ImageIO.read(url))
        } catch (ex: Exception) {
            ByteArray(0)
        }
    }

    private fun bufferedImageToByteArray(image: BufferedImage): ByteArray {
        val outputStream = ByteArrayOutputStream()
        ImageIO.write(image, "jpg", outputStream)
        return outputStream.toByteArray()
    }
}
