package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class MintageRequest(
    @Schema(example = "Standing Liberty Quarter")
    val type: String,
    @Schema(example = "1917")
    val year: String,
    @Schema(example = "D")
    val mintMark: String?,
    @Schema(example = "Ty. 1")
    val details: String?
)
