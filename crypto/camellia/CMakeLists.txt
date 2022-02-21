CYREN_INSTALL_HEADERS(camellia.h PREFIX openssl)
CYREN_INSTALL_HEADERS(cmll_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    cmll_ecb.c
    cmll_cfb.c
    cmll_ctr.c
    cmll_ofb.c
    cmll_utl.c
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/cmll-x86_64.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_SOURCES(
        cmll_misc.c
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/cmll-x86.pl
        PARENT_SCOPE PERLASM)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        camellia.c
        cmll_cbc.c
        cmll_misc.c
        PARENT_SCOPE)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()
