package com.pscottzero.controller

import com.pscottzero.model.*
import com.pscottzero.service.CoinDataService
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/coin")
@Tag(name = "Coin Data Controller")
class CoinDataController {
    @Autowired
    lateinit var coinDataService: CoinDataService

    @GetMapping("/types")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve all valid coin types")
    fun getCoinTypes(): ResponseEntity<List<String>> {
        return ResponseEntity.ok(CoinType.values().map { it.toString() })
    }

    @PostMapping("/retailPrice")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve retail price of specified coin")
    fun getCoinPrice(
        @RequestBody priceRequest: PriceRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getRetailPrice(priceRequest))
    }

    @PostMapping("/retailPrice/greysheet-format")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve retail price of specified coin using greysheet format")
    fun getCoinPrice(
        @RequestBody greysheetPriceRequest: GreysheetPriceRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getRetailPrice(greysheetPriceRequest))
    }

    @PostMapping("/mintage")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve mintage of specified coin")
    fun getMintage(
        @RequestBody mintageRequest: MintageRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getMintage(mintageRequest))
    }

    @PostMapping("/mintage/greysheet-format")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve mintage of specified coin using greysheet format")
    fun getMintage(
        @RequestBody greysheetMintageRequest: GreysheetMintageRequest
    ): ResponseEntity<String> {
        return ResponseEntity.ok(coinDataService.getMintage(greysheetMintageRequest))
    }

    @PostMapping("/images")
    @CrossOrigin(origins = ["*"])
    @Operation(summary = "Retrieve coin obverse and reverse images")
    fun getPhotos(
        @RequestBody photogradeRequest: PCGSPhotogradeRequest
    ): ResponseEntity<List<ByteArray>> {
        return ResponseEntity.ok(
            listOf(
                coinDataService.getPhoto(photogradeRequest, CoinSide.OBVERSE),
                coinDataService.getPhoto(photogradeRequest, CoinSide.REVERSE)
            )
        )
    }
}
