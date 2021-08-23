package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class CoinDataRequest(
    @Schema(example = "Morgan Dollar")
    val type: String,
    @Schema(example = "1879")
    val year: String,
    @Schema(example = "CC")
    val mintMark: String?,
    @Schema(example = "Capped")
    val details: String?,
    @Schema(example = "MS-65")
    val grade: String?
)
