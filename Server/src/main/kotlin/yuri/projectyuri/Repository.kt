package yuri.projectyuri

import org.springframework.data.jpa.repository.JpaRepository

interface ProductionRepository: JpaRepository<Production, Long>

interface ProducerRepository: JpaRepository<Producer, Long>

interface CharactersRepository: JpaRepository<Characters, Long>

interface CommentRepository: JpaRepository<Comment, Long>

interface UserRepository: JpaRepository<User, Long>

interface UserProductionRepository: JpaRepository<UserProduction, UserProduction.UserProductionID>



//interface EmployeeRepository: JpaRepository<Employee, Long>
//
//interface DepartmentRepository: JpaRepository<Department, Long>



