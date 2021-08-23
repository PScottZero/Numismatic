package com.pscottzero.model

import io.swagger.v3.oas.annotations.media.Schema

data class GreysheetDataRequest(
    @Schema(example = "New Jersey")
    val type: String,
    @Schema(example = "1787 NJ Sm Plan, Pl Shield BN")
    val variant: String,
    @Schema(example = "XF40")
    val grade: String?
)