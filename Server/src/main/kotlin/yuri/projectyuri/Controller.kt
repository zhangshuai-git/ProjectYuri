package yuri.projectyuri

import io.swagger.annotations.Api
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

//@RestController
//@RequestMapping("/api/v1/employee")
//@Api(tags = ["Employee"])
//class EmployeeController {
//
//    @Autowired
//    lateinit var service: EmployeeService
//
//    @GetMapping
//    fun getAllEmployee(
//            @RequestParam(required = false, defaultValue = "0") page: Int,
//            @RequestParam(required = false, defaultValue = "10") size: Int
//    ) = Result(PageResult(service.findAll(page, size)))
//
//    @GetMapping("/{id}")
//    fun getEmployee(@PathVariable id: Long) = Result(service.find(id))
//
//    @PostMapping
//    fun createEmployee(@RequestBody employee: Employee?) = employee
//            ?.let { Result(service.create(it)) }
//            ?: throw CustomException(ErrorEnum.PARAM_ERROR)
//
//    @PutMapping
//    fun updateEmployee(@RequestBody employee: Employee?) = employee
//            ?.let { Result(service.update(it)) }
//            ?: throw CustomException(ErrorEnum.PARAM_ERROR)
//
//    @DeleteMapping("/{id}")
//    fun deleteEmployee(@PathVariable id: Long) = Result(service.delete(id))
//
//}

