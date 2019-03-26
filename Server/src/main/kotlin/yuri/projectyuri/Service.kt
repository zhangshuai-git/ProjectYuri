package yuri.projectyuri

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class EmployeeService {

    @Autowired
    lateinit var employeeRepository: EmployeeRepository

    @Autowired
    lateinit var departmentRepository: DepartmentRepository

    @Transactional
    fun findAll(page: Int, size: Int) = PageRequest.of(page, size)
            .debug()
            .let { employeeRepository.findAll(it) }
            .takeIf { it.pageable.pageNumber < it.totalPages }
            ?: throw CustomException(ErrorEnum.PARAM_ERROR)

    @Transactional
    fun find(id: Long) = employeeRepository.findById(id).toNullable()
            ?: throw CustomException(ErrorEnum.RESOURCE_ERROR)

    @Transactional
    fun create(employee: Employee) = employee
            .debug()
            .takeUnless { employeeRepository.existsById(it.id) }
            ?.also { updateDepartment(it) }
            ?.let { employeeRepository.save(it) }
            ?: throw CustomException(ErrorEnum.ALREADY_EXISTS_ERROR)

    @Transactional
    fun update(employee: Employee) = employee
            .debug()
            .takeIf { employeeRepository.existsById(it.id) }
            ?.also { updateDepartment(it) }
            ?.let { employeeRepository.save(it) }
            ?: throw CustomException(ErrorEnum.RESOURCE_ERROR)

    @Transactional
    fun delete(id: Long) = employeeRepository.deleteById(id)

    private fun updateDepartment(employee: Employee) = employee.department?.id
            ?.let { departmentRepository.findById(it).toNullable() }
            ?.also { employee.department = it }
            ?: throw CustomException(ErrorEnum.PARAM_ERROR)

}
