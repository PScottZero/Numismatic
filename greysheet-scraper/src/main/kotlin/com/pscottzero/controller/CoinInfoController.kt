package com.pscottzero.controller

import com.pscottzero.model.CoinType
import com.pscottzero.model.CoinDataRequest
import com.pscottzero.model.ScraperResponse
import com.pscottzero.service.CoinInfoService
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.ArraySchema
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.ExampleObject
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import it.skrape.fetcher.request.Json
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController()
@RequestMapping("/coin")
class CoinInfoController {
    @Autowired
    lateinit var coinInfoService: CoinInfoService

    @GetMapping("/types")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve all valid coin types")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Successfully retrieved coin types",
                content = [
                    Content(
                        array = ArraySchema(schema = Schema(implementation = String::class)),
                        examples = [ExampleObject("[\"Peace Dollar\", \"Morgan Dollar\"]")]
                    )
                ]
            )
        ]
    )
    fun getCoinTypes(): ResponseEntity<List<String>> {
        return ResponseEntity.ok(CoinType.values().map { it.toString() })
    }

    @PostMapping("/retailValue")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve value of specified coin from Greysheet")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Successfully retrieved coin value",
                content = [
                    Content(
                        schema = Schema(implementation = ScraperResponse::class),
                        examples = [ExampleObject("{\"success\": true, \"payload\": \"\$123.45\"}")]
                    )
                ]
            ),
            ApiResponse(
                responseCode = "400",
                description = "Bad request",
                content = [
                    Content(
                        schema = Schema(implementation = ScraperResponse::class),
                        examples = [ExampleObject("{\"success\": false, \"errorMessage\": \"Error retrieving coin value\"}")]
                    )
                ]
            )
        ]
    )
    fun getCoinValue(
        @RequestBody coinValueRequest: CoinDataRequest
    ): ResponseEntity<ScraperResponse<String>> {
        val value = coinInfoService.getRetailValue(coinValueRequest)
        return if (value.success) {
            ResponseEntity.ok(value)
        } else {
            ResponseEntity.badRequest().body(value)
        }
    }

    @GetMapping("/links")
    fun coinTypeLinks(): ResponseEntity<Map<String, String>> {
        return ResponseEntity.ok(coinInfoService.coinTypeLinks())
    }
}
