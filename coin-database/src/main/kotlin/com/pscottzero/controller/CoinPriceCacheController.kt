package com.pscottzero.controller

import com.pscottzero.service.CoinPriceCacheService
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.ExampleObject
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/cache")
class CoinPriceCacheController {
    @Autowired
    lateinit var coinPriceCacheService: CoinPriceCacheService

    @GetMapping
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Get coin prices cache as json")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Retrieved coin prices cache",
                content = [
                    Content(
                        schema = Schema(
                            implementation = Map::class
                        ),
                        examples = [
                            ExampleObject(
                                value = "{\"Liberty Cap Half Cents\": {\"1793\": {\"MS65 CAC\": \"\$456,000.00\",\"MS65\": \"\$300,000.00\",\"MS64 CAC\": \"\$180,000.00\",\"MS64\": \"\$102,000.00\"}}}"
                            )
                        ]
                    )
                ]
            )
        ]
    )
    fun getCache(): ResponseEntity<Map<String, Map<String, Map<String, String>>>> {
        return ResponseEntity.ok(coinPriceCacheService.coinPriceCache.readAll())
    }

    @PostMapping("/refresh")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Refresh coin prices cache")
    fun refreshCache(): ResponseEntity<String> {
        return ResponseEntity.ok(coinPriceCacheService.refreshCache())
    }
}