package yuri.projectyuri.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.authentication.dao.DaoAuthenticationProvider
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import yuri.projectyuri.service.AppUserDetailsService
import org.springframework.security.config.annotation.web.builders.WebSecurity
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
class WebConfig(
  val bCryptPasswordEncoder: BCryptPasswordEncoder,
  val userDetailsService: AppUserDetailsService
) : WebSecurityConfigurerAdapter() {

//  private val swaggerRouts = arrayOf("/v2/api-docs", "/configuration/ui", "/swagger-resources/**", "/configuration/security", "/swagger-ui.html", "/webjars/**")
////  private val swaggerRouts = arrayOf("/v2/api-docs",//swagger api json
////          "/swagger-resources/configuration/ui",//用来获取支持的动作
////          "/swagger-resources",//用来获取api-docs的URI
////          "/swagger-resources/configuration/security",//安全选项
////          "/swagger-ui.html")
//
//
//  override fun configure(web: WebSecurity) {
//    web.ignoring().antMatchers(*swaggerRouts)
////    web.ignoring().antMatchers(HttpMethod.OPTIONS, "/**")
//  }

  override fun configure(http: HttpSecurity) {

    http.authorizeRequests()
        .anyRequest().permitAll().and().logout().permitAll()
//    http
//      .cors().and()
//      .csrf().disable()
//      .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS) // no sessions
//      .and()
//      .authorizeRequests()
//      .antMatchers(*swaggerRouts).permitAll()
////      .antMatchers("/api/**").permitAll()
////      .antMatchers("/error/**").permitAll()
////      .antMatchers(HttpMethod.POST, "/login").permitAll()
//      .anyRequest().authenticated()
//      .and()
//      .addFilter(JWTAuthenticationFilter(authenticationManager()))
//      .addFilter(JWTAuthorizationFilter(authenticationManager()))
  }

  @Throws(Exception::class)
  override fun configure(auth: AuthenticationManagerBuilder) {
    auth.userDetailsService(userDetailsService)
      .passwordEncoder(bCryptPasswordEncoder)
  }

  @Bean
  fun authProvider(): DaoAuthenticationProvider {
    val authProvider = DaoAuthenticationProvider()
    authProvider.setUserDetailsService(userDetailsService)
    authProvider.setPasswordEncoder(bCryptPasswordEncoder)
    return authProvider
  }
}
