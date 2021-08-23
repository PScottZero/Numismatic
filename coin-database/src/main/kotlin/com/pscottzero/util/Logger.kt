package com.pscottzero.util

import org.slf4j.LoggerFactory

open class Logger {
    private val logger = LoggerFactory.getLogger(Logger::class.java)
    fun info(message: String) = logger.info(message)
    fun error(message: String) = logger.error(message)
}