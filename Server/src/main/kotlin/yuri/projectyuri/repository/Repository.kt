package yuri.projectyuri.repository

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import yuri.projectyuri.domain.*

interface ProductionRepository : JpaRepository<Production, Long> {
    @Query("select p from Production p where p.name like %?1% or p.nameCN like %?1%")
    fun findSearch(query: String, pageable: Pageable): Page<Production>
}

interface CharactersRepository : JpaRepository<Characters, Long>

interface CommentRepository : JpaRepository<Comment, Long>

interface UserRepository : JpaRepository<User, Long> {
    fun findByUsername(username: String): User?
}

interface UserProductionRepository : JpaRepository<UserProduction, UserProduction.UserProductionID>




