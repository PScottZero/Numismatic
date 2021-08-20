package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class CoinValueRequest(
    @Schema(example = "Morgan Dollar")
    val type: String,
    @Schema(example = "1878")
    val year: Int,
    @Schema(example = "CC")
    val mintMark: String?,
    @Schema(example = "MS-64")
    val grade: String
)
