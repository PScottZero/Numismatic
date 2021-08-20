package com.pscottzero.controller

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class DefaultController {
    @GetMapping("/")
    fun getHome(): ResponseEntity<String> {
        return ResponseEntity.ok(javaClass.getResource("/index.html")?.readText() ?: "Greysheet Scraper")
    }

    @GetMapping("/error")
    fun getError(): ResponseEntity<String> {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Greysheet Scraper Error!")
    }
}