package com.pscottzero.util

import com.pscottzero.model.CoinType
import com.pscottzero.model.MintageRequest
import com.pscottzero.model.PriceRequest

class RequestToVariants {
    companion object {
        fun priceRequestToGreysheetVariants(priceRequest: PriceRequest): Pair<String, String>? {
            val type = CoinType.fromString(priceRequest.type)
            if (type != null) {
                val mintMark = if (priceRequest.mintMark != null) "-${priceRequest.mintMark}" else ""
                val gradeSplit = priceRequest.grade.split("-")
                val details = "${priceRequest.details ?: ""} ${if (gradeSplit.size >= 3) gradeSplit[2] else ""}".trim()
                val variantNoComma = "${priceRequest.year}${mintMark} $details".trim()
                val variantWithComma = "${priceRequest.year}${mintMark}, $details"
                return Pair(variantNoComma, variantWithComma)
            }
            return null
        }

        fun mintageRequestToGreysheetVariants(mintageRequest: MintageRequest): Pair<String, String>? {
            val type = CoinType.fromString(mintageRequest.type)
            if (type != null) {
                val mintMark = if (mintageRequest.mintMark != null) "-${mintageRequest.mintMark}" else ""
                val variantNoComma = "${mintageRequest.year}${mintMark} ${mintageRequest.details ?: ""}".trim()
                val variantWithComma = "${mintageRequest.year}${mintMark}, ${mintageRequest.details ?: ""}"
                return Pair(variantNoComma, variantWithComma)
            }
            return null
        }
    }
}