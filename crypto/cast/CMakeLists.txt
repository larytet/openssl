CYREN_INSTALL_HEADERS(cast.h PREFIX openssl)
CYREN_INSTALL_HEADERS(cast_s.h cast_lcl.h INTERNAL)

CHECK_C_COMPILER_FLAG(-Wno-old-style-declaration HAVE_WNO_OLD_STYLE_DECLARATION)
IF(HAVE_WNO_OLD_STYLE_DECLARATION)
    ADD_DEFINITIONS(-Wno-old-style-declaration)
ENDIF()

OPENSSL_ADD_CRYPTO_SOURCES(
    c_skey.c
    c_ecb.c
    c_cfb64.c
    c_ofb64.c
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        c_enc.c
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/cast-586.pl
        PARENT_SCOPE PERLASM)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        c_enc.c
        PARENT_SCOPE)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

IF(EXPENSIVE_TESTS)
    OPENSSL_ADD_CRYPTO_TESTS(
        casttest.c
        PARENT_SCOPE)
ENDIF()
