package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class GreysheetPriceRequest(
    @Schema(example = "Morgan Dollars")
    val type: String,
    @Schema(example = "1879-CC Capped")
    val variant: String,
    @Schema(example = "MS65")
    val grade: String
)
