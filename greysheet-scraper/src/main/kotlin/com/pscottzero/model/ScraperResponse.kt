package com.pscottzero.model

data class ScraperResponse<T>(
    val success: Boolean,
    val errorMessage: String? = null,
    val payload: T? = null,
) {
    companion object {
        fun <T> error(message: String) = ScraperResponse<T>(
            success = false,
            errorMessage = message
        )

        fun <T> success(payload: T) = ScraperResponse(
            success = true,
            payload = payload
        )
    }
}