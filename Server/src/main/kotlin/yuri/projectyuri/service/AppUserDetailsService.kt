package yuri.projectyuri.service

import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Component
import yuri.projectyuri.repository.UserRepository
import java.util.*

@Component
class AppUserDetailsService(val userRepository: UserRepository) : UserDetailsService {

    @Throws(UsernameNotFoundException::class)
    override fun loadUserByUsername(s: String): UserDetails {
        val user: yuri.projectyuri.domain.User? = userRepository.findByUsername(s)
            ?: throw UsernameNotFoundException("The username $s doesn't exist")

        val authorities = ArrayList<GrantedAuthority>()
        user!!.roles.forEach { role -> authorities.add(SimpleGrantedAuthority(role.roleName)) }

        return User(
            user.username,
            user.password,
            authorities
        )
    }
}
