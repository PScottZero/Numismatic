package com.pscottzero.controller

import com.pscottzero.model.CoinType
import com.pscottzero.model.CoinDataRequest
import com.pscottzero.model.GreysheetDataRequest
import com.pscottzero.service.CoinDataService
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.media.ArraySchema
import io.swagger.v3.oas.annotations.media.Content
import io.swagger.v3.oas.annotations.media.ExampleObject
import io.swagger.v3.oas.annotations.media.Schema
import io.swagger.v3.oas.annotations.responses.ApiResponse
import io.swagger.v3.oas.annotations.responses.ApiResponses
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/coin")
class CoinDataController {
    @Autowired
    lateinit var coinDataService: CoinDataService

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

    @PostMapping("/retailPrice")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve retail price of specified coin from Greysheet")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Returned price or error message",
                content = [
                    Content(
                        schema = Schema(implementation = String::class),
                        examples = [ExampleObject("$1,195.00")]
                    )
                ]
            ),
        ]
    )
    fun getCoinPrice(
        @RequestBody coinDataRequest: CoinDataRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getRetailPrice(coinDataRequest))
    }

    @PostMapping("/retailPrice/greysheet-format")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve retail price of specified coin from Greysheet in type, variant, grade format")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Returned price or error message",
                content = [
                    Content(
                        schema = Schema(implementation = String::class),
                        examples = [ExampleObject("$1,195.00")]
                    )
                ]
            ),
        ]
    )
    fun getCoinPrice(
        @RequestBody greysheetDataRequest: GreysheetDataRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getRetailPrice(greysheetDataRequest))
    }

    @PostMapping("/mintage")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve mintage of specified coin")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Returned mintage or error message",
                content = [
                    Content(
                        schema = Schema(implementation = String::class),
                        examples = [ExampleObject("2,212,000")]
                    )
                ]
            ),
        ]
    )
    fun getMintage(
        @RequestBody coinDataRequest: CoinDataRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getMintage(coinDataRequest))
    }

    @PostMapping("mintage/greysheet-format")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve mintage of specified coin using greysheet format")
    @ApiResponses(
        value = [
            ApiResponse(
                responseCode = "200",
                description = "Returned mintage or error message",
                content = [
                    Content(
                        schema = Schema(implementation = String::class),
                        examples = [ExampleObject("2,212,000")]
                    )
                ]
            ),
        ]
    )
    fun getMintage(
        @RequestBody greysheetDataRequest: GreysheetDataRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getMintage(greysheetDataRequest))
    }
}
