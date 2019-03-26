package yuri.projectyuri

import org.springframework.data.domain.Page
import org.springframework.format.annotation.DateTimeFormat
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

enum class Gender { MALE, FEMALE }

@Entity
class Employee(@Id @GeneratedValue var id: Long) {

    @Column
    var name: String? = null

    @Column
    @Enumerated
    var gender: Gender? = null

    @ManyToOne(cascade = [CascadeType.MERGE])
    var department: Department? = null

    @Column
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    var birthDate: Date = Date()

    override fun toString(): String = toJsonString()
}

@Entity
class Department(@Id @GeneratedValue var id: Long) {

    @Column(unique = true)
    var departmentName: String? = null

    override fun toString(): String = toJsonString()
}

