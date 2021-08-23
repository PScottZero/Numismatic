package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class GreysheetMintageRequest(
    @Schema(example = "Standing Liberty Quarters")
    val type: String,
    @Schema(example = "1917-D Ty. 1")
    val variant: String
)
