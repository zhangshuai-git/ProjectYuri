package yuri.projectyuri

import io.swagger.annotations.Api
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.servlet.support.ServletUriComponentsBuilder
import java.io.IOException
import java.util.*
import java.util.stream.Collectors
import javax.servlet.http.HttpServletRequest

@RestController
@Api(tags = ["File"])
class FileController {

    private val logger = LoggerFactory.getLogger(FileController::class.java)

    @Autowired
    lateinit var fileStorageService: FileStorageService

    @PostMapping("/uploadFile")
    fun uploadFile(@RequestParam("file") file: MultipartFile): Result<UploadFileResponse> {
        val fileName = fileStorageService.storeFile(file)

        val fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/downloadFile/")
                .path(fileName)
                .toUriString()

        return Result(UploadFileResponse(fileName, fileDownloadUri,
                file.contentType, file.size))
    }

    @PostMapping("/uploadMultipleFiles")
    fun uploadMultipleFiles(@RequestParam("files") files: Array<MultipartFile>): Result<List<UploadFileResponse>> {
        return Result(Arrays
                .asList(*files)
                .stream()
                .map { file -> uploadFile(file).data }
                .collect(Collectors.toList())
                .orEmpty())
    }

    @GetMapping("/downloadFile/{fileName:.+}")
    fun downloadFile(@PathVariable fileName: String, request: HttpServletRequest): ResponseEntity<Resource> {
        // Load file as Resource
        val resource = fileStorageService.loadFileAsResource(fileName)

        // Try to determine file's content type
        var contentType: String? = null
        try {
            contentType = request.servletContext.getMimeType(resource.file.absolutePath)
        } catch (ex: IOException) {
            logger.info("Could not determine file type.")
        }

        // Fallback to the default content type if type could not be determined
        if (contentType == null) {
            contentType = "application/octet-stream"
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body(resource)
    }

}

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

