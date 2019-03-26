package yuri.projectyuri

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import java.util.*
import kotlin.reflect.KClass

fun Any.toJsonString(): String = jacksonObjectMapper().writeValueAsString(this)

fun Any.toJson(): Map<*, *> = jacksonObjectMapper().readValue(this.toJsonString(), Map::class.java)

inline fun <reified T : Any> String.toBean(): T = jacksonObjectMapper().readValue(this, T::class.java)

fun <T : Any> Map<String, *>.toBean(kClass: KClass<T>): T = jacksonObjectMapper().convertValue(this, kClass.java)

fun <T> Optional<T>.toNullable(): T? = orElse(null)

fun <T : Any> T.debug(msg: String = toString(), tag: String? = null): T = also { ZSLog(msg, tag = tag, index = 3) }
