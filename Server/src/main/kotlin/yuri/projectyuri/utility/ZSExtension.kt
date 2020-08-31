package yuri.projectyuri.utility

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import java.text.SimpleDateFormat
import java.util.*
import kotlin.reflect.KClass

fun <T> log(msg: T, tag: String? = null, index: Int = 2) {
    val date: String = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Date())
    val s: StackTraceElement = Throwable().stackTrace[index]
    println("${tag ?: date}  $s  $msg")
}

fun Any.toJsonString(): String = jacksonObjectMapper().writeValueAsString(this)

fun Any.toJson(): Map<*, *> = jacksonObjectMapper().readValue(this.toJsonString(), Map::class.java)

inline fun <reified T : Any> String.toBean(): T = jacksonObjectMapper().readValue(this, T::class.java)

fun <T : Any> Map<String, *>.toBean(kClass: KClass<T>): T = jacksonObjectMapper().convertValue(this, kClass.java)

fun <T> Optional<T>.toNullable(): T? = orElse(null)

fun <T : Any> T.debug(msg: String = toString(), tag: String? = null): T = also { log(msg, tag = tag, index = 3) }
