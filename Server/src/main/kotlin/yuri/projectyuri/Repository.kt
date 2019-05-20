package yuri.projectyuri

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface ProductionRepository: JpaRepository<Production, Long> {
    @Query("select p from Production p where p.name like %?1% or p.nameCN like %?1%")
    fun findSearch(query: String, pageable: Pageable): Page<Production>
}

interface CharactersRepository: JpaRepository<Characters, Long>

interface CommentRepository: JpaRepository<Comment, Long>

interface UserRepository: JpaRepository<User, Long>

interface UserProductionRepository: JpaRepository<UserProduction, UserProduction.UserProductionID>




