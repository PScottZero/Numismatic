package com.pscottzero.util

import com.pscottzero.model.CoinDataRequest
import com.pscottzero.model.CoinType

class CoinVariantTranslator {
    companion object {
        fun dataRequestToGreysheetVariants(dataRequest: CoinDataRequest): Pair<String, String>? {
            val type = CoinType.fromString(dataRequest.type)
            if (type != null) {
                val mintMark = if (dataRequest.mintMark != null) "-${dataRequest.mintMark}" else ""
                val gradeSplit = dataRequest.grade?.split("-") ?: emptyList()
                val details = "${dataRequest.details ?: ""} ${if (gradeSplit.size >= 3) gradeSplit[2] else ""}".trim()
                val variantNoComma = "${dataRequest.year}${mintMark} $details".trim()
                val variantWithComma = "${dataRequest.year}${mintMark}, $details"
                return Pair(variantNoComma, variantWithComma)
            }
            return null
        }
    }
}