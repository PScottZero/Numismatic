package com.pscottzero.model

data class CoinValueRequest(
    val type: String,
    val year: Int,
    val mintMark: String?,
    val grade: String
)