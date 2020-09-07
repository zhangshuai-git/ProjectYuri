package yuri.projectyuri.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import yuri.projectyuri.common.SecurityConstants

@Configuration
class AppConfiguration {
  @Bean
  fun bCryptPasswordEncoder(): BCryptPasswordEncoder {
    return BCryptPasswordEncoder(SecurityConstants.STRENGTH)
  }
}
