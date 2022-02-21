CYREN_INSTALL_HEADERS(sha.h PREFIX openssl)
CYREN_INSTALL_HEADERS(sha_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    sha_dgst.c
    sha1dgst.c
    sha_one.c
    sha1_one.c
    sha256.c
    sha512.c
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/sha1-x86_64.pl
        asm/sha1-mb-x86_64.pl
        asm/sha256-mb-x86_64.pl
        asm/sha512-x86_64.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DSHA1_ASM
        -DSHA256_ASM
        -DSHA512_ASM
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/sha1-586.pl
        asm/sha256-586.pl
        asm/sha512-586.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DSHA1_ASM
        -DSHA256_ASM
        -DSHA512_ASM
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/sha1-ppc.pl
        asm/sha512-ppc.pl
        asm/sha512p8-ppc.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DSHA1_ASM
        -DSHA256_ASM
        -DSHA512_ASM
        PARENT_SCOPE)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

OPENSSL_ADD_CRYPTO_TESTS(
    shatest.c
    sha1test.c
    sha256t.c
    sha512t.c
    PARENT_SCOPE)
