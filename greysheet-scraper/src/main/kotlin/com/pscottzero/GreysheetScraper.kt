package com.pscottzero

import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.PathItem
import io.swagger.v3.oas.models.Paths
import io.swagger.v3.oas.models.info.Info
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.context.annotation.Bean

@SpringBootApplication
open class GreysheetScraper {
    @Bean
    open fun api(): OpenAPI = OpenAPI()
        .info(
            Info()
                .title("Numismatic App's Coin Info Service")
        )
}

fun main(args: Array<String>) {
    SpringApplication.run(GreysheetScraper::class.java, *args)
}