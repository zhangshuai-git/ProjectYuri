package yuri.projectyuri

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.hibernate.service.spi.ServiceException
import org.springframework.core.io.Resource
import org.springframework.core.io.UrlResource
import org.springframework.data.domain.Page
import org.springframework.util.StringUtils
import java.util.UUID
import java.text.SimpleDateFormat
import org.springframework.util.StringUtils.endsWithIgnoreCase
import java.util.HashMap
import org.springframework.web.multipart.MultipartFile
import java.io.IOException
import java.net.MalformedURLException
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.nio.file.StandardCopyOption
import javax.transaction.TransactionScoped


@Service
class FileStorageService {

    @Autowired
    constructor(fileStorageProperties: FileStorageProperties) {
        this.fileStorageLocation = Paths.get(fileStorageProperties.uploadDir)
                .toAbsolutePath().normalize()
        try {
            Files.createDirectories(this.fileStorageLocation)
        } catch (ex: Exception) {
            throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)
        }
    }

    private val fileStorageLocation: Path

    fun storeFile(file: MultipartFile): String {
        // Normalize file name
        val fileName = file.originalFilename?.let { StringUtils.cleanPath(it) } ?: throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)

        try {
            // Check if the file's name contains invalid characters
            if (fileName.contains("..")) {
                throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)
            }

            // Copy file to the target location (Replacing existing file with the same name)
            val targetLocation = this.fileStorageLocation.resolve(fileName)
            Files.copy(file.inputStream, targetLocation, StandardCopyOption.REPLACE_EXISTING)

            return fileName
        } catch (ex: IOException) {
            throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)
        }

    }

    fun loadFileAsResource(fileName: String): Resource {
        try {
            val filePath = this.fileStorageLocation.resolve(fileName).normalize()
            val resource = UrlResource(filePath.toUri())
            return if (resource.exists()) {
                resource
            } else {
                throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)
            }
        } catch (ex: MalformedURLException) {
            throw CustomException(ErrorEnum.FILE_STORAGE_ERROR)
        }

    }
}

@Service
class ProductionService {

    @Autowired
    lateinit var productionRepository: ProductionRepository

    @Transactional
    fun save(production: Production): Production {
        return production
                ?.let { productionRepository.save(it) }
    }

    @Transactional
    fun findAll(page: Int, size: Int): Page<Production> {
        return PageRequest.of(page, size)
                .debug()
                .let { productionRepository.findAll(it) }
                .takeIf { it.pageable.pageNumber < it.totalPages }
                ?: throw CustomException(ErrorEnum.PARAM_ERROR)
    }

}

//@Service
//class EmployeeService {
//
//    @Autowired
//    lateinit var employeeRepository: EmployeeRepository
//
//    @Autowired
//    lateinit var departmentRepository: DepartmentRepository
//
//    @Transactional
//    fun findAll(page: Int, size: Int) = PageRequest.of(page, size)
//            .debug()
//            .let { employeeRepository.findAll(it) }
//            .takeIf { it.pageable.pageNumber < it.totalPages }
//            ?: throw CustomException(ErrorEnum.PARAM_ERROR)
//
//    @Transactional
//    fun find(id: Long) = employeeRepository.findById(id).toNullable()
//            ?: throw CustomException(ErrorEnum.RESOURCE_ERROR)
//
//    @Transactional
//    fun create(employee: Employee) = employee
//            .debug()
//            .takeUnless { employeeRepository.existsById(it.id) }
//            ?.also { updateDepartment(it) }
//            ?.let { employeeRepository.save(it) }
//            ?: throw CustomException(ErrorEnum.ALREADY_EXISTS_ERROR)
//
//    @Transactional
//    fun update(employee: Employee) = employee
//            .debug()
//            .takeIf { employeeRepository.existsById(it.id) }
//            ?.also { updateDepartment(it) }
//            ?.let { employeeRepository.save(it) }
//            ?: throw CustomException(ErrorEnum.RESOURCE_ERROR)
//
//    @Transactional
//    fun delete(id: Long) = employeeRepository.deleteById(id)
//
//    private fun updateDepartment(employee: Employee) = employee.department?.id
//            ?.let { departmentRepository.findById(it).toNullable() }
//            ?.also { employee.department = it }
//            ?: throw CustomException(ErrorEnum.PARAM_ERROR)
//
//}
