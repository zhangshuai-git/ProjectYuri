package yuri.projectyuri

import org.springframework.data.jpa.repository.JpaRepository

interface EmployeeRepository: JpaRepository<Employee, Long>

interface DepartmentRepository: JpaRepository<Department, Long>