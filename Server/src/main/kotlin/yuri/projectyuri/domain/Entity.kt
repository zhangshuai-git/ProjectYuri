package yuri.projectyuri.domain

import org.springframework.data.domain.Page
import java.io.Serializable
import java.util.*
import javax.persistence.*

class Result<T>(val data: T) {
    val code: Int = 0
    val message: String = "成功"
}

class PageResult<T>(page: Page<T>) {
    var totalCount: Long = page.totalElements
    var totalPage: Int = page.totalPages
    var currentPage: Int = page.pageable.pageNumber
    var items: Collection<T> = page.content
}

class UploadFileResponse(var fileName: String?, var fileDownloadUri: String?, var fileType: String?, var size: Long)

@Entity
class Production(@Id @GeneratedValue var id: Long) {

    var name: String = ""

    var nameCN: String = ""

    var desp: String = ""

    var info: String = ""

    var coverUrl: String = ""

    @Enumerated(EnumType.STRING)
    var category: ProductionCategory? = null

    @OneToMany(cascade = [CascadeType.MERGE])
    var charactersList: Collection<Characters> = emptyList()

    @OneToMany(cascade = [CascadeType.MERGE])
    var commentList: Collection<Comment> = emptyList()
}

@Entity
class Characters(@Id @GeneratedValue var id: Long) {

    var avatarUrl: String = ""

    var name: String = ""

    var cv: String = ""
}

@Entity
class Comment(@Id @GeneratedValue var id: Long) {

    var content: String = ""

    @ManyToOne(cascade = [CascadeType.MERGE])
    var author: User? = null

    @Temporal(TemporalType.TIMESTAMP)
    var date: Date = Date()
}

@Entity
class User(@Id @GeneratedValue var id: Long) {

    var username: String = ""

    var password: String = ""

    var nickname: String = ""

    var avatarUrl: String = ""

    @OneToMany(mappedBy = "user")
    var productionList: Collection<UserProduction> = emptyList()

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        joinColumns = [JoinColumn(name = "user_id", referencedColumnName = "id")],
        inverseJoinColumns = [JoinColumn(name = "role_id", referencedColumnName = "id")]
    )
    var roles: Collection<Role> = emptyList()
}

@Entity
class Role(@Id @GeneratedValue var id: Long) {

    var roleName: String? = null

    var description: String? = null
}


@Entity
class UserProduction(@EmbeddedId var id: UserProductionID) {

    @Embeddable
    data class UserProductionID(var userID: Long, var productionID: Long) : Serializable

    @ManyToOne(cascade = [CascadeType.MERGE])
    var user: User? = null

    @ManyToOne(cascade = [CascadeType.MERGE])
    var production: Production? = null

    @Enumerated(EnumType.STRING)
    var evaluation: Evaluation? = null

    @Enumerated(EnumType.STRING)
    var schedule: Schedule? = null
}

enum class Schedule {
    TODO, DOING, DONE
}

enum class Evaluation {
    LIKE, CRITICISM
}

enum class ProductionCategory {
    GAME, ANIME, COMIC, NOVEL
}
