package com.pscottzero.controller

import io.swagger.v3.oas.annotations.Hidden
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class DefaultController {
    @Hidden
    @GetMapping("/")
    fun getHome(): ResponseEntity<String> {
        return ResponseEntity.ok(javaClass.getResource("/index.html")?.readText() ?: "Greysheet Scraper")
    }

    @Hidden
    @GetMapping("/favicon.ico")
    fun getFavicon(): ResponseEntity<ByteArray> {
        return ResponseEntity.ok(javaClass.getResource("/favicon.ico")?.readBytes() ?: ByteArray(0))
    }

    @Hidden
    @GetMapping("/nj-colonial.jpg")
    fun getHomeImage(): ResponseEntity<ByteArray> {
        return ResponseEntity.ok(javaClass.getResource("/nj-colonial.jpg")?.readBytes() ?: ByteArray(0))
    }

    @Hidden
    @GetMapping("/error")
    fun getError(): ResponseEntity<String> {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Backend Error!")
    }
}