package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class PCGSPhotogradeRequest(
    @Schema(example = "Morgan Dollar")
    val type: String,
    @Schema(example = "MS-65")
    val grade: String
)
