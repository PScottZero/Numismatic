package com.pscottzero

import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.info.Info
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.context.annotation.Bean

@SpringBootApplication
open class CoinDatabaseApp {
    @Bean
    open fun api(): OpenAPI = OpenAPI()
        .info(
            Info()
                .title("Coin Database REST Endpoints")
        )
}

fun main(args: Array<String>) {
    SpringApplication.run(CoinDatabaseApp::class.java, *args)
}