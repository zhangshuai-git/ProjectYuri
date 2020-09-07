package yuri.projectyuri.common

object SecurityConstants {
    var SECRET: String = System.getenv("SECRET") ?: "!s0=M..-a%&r^^^!!7Kßßäö84834=/=(9393DFDFSerwww03838perDFdejS&4"
    const val EXPIRATION_TIME: Long = 1800000
    const val HEADER_STRING = "Authorization"
    const val STRENGTH = 10
}
